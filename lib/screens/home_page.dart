import '../imports/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MqttServerClient client;
  TextEditingController _topicController =
      TextEditingController(text: 'my/test/topic');
  TextEditingController _messageController = TextEditingController();
  List<String> messages = [];

  Future<void> setupMqtt() async {
    client = MqttServerClient('broker.mqtt.cool', '');
    client.port = 1883;
    client.logging(on: true);

    void onDisconnected() {
      logger.e('Disconnected');
    }

    client.clientIdentifier = 'FlutterClient';
    client.keepAlivePeriod = 60;
    client.onDisconnected = onDisconnected;

    try {
      await client.connect();
    } catch (e) {
      logger.e(e);
      client.disconnect();
    }

    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      logger.f('Connected Successfully');
      subscribeToTopic(_topicController.text);
    } else {
      logger.e('Connection Failed');
    }

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final responseMessage = c![0].payload as MqttPublishMessage;
      final pt = MqttPublishPayload.bytesToStringAsString(
          responseMessage.payload.message);

      setState(() {
        messages.insert(0, 'Received from ${c[0].topic}: $pt');
      });

      logger.w('Received Message:${pt} from topic: ${c[0].topic}');
    });
  }

  void subscribeToTopic(String topic) {
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  void publishMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(_messageController.text);
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);

    setState(() {
      messages.insert(0, 'Published to $topic: $message');
    });
  }

  @override
  void initState() {
    setupMqtt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Style.colors.primary,
          title: Text(
            'Task',
            style: Style.textStyles.primary(
              color: Style.colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            children: [
              CustomInputField(
                controller: _topicController,
                placeHolder: 'Topic',
                keyBoardType: TextInputType.text,
              ),
              CustomInputField(
                controller: _messageController,
                placeHolder: 'Message',
                keyBoardType: TextInputType.text,
              ),
              3.h.hGap,
              SizedBox(
                width: 100.w,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final topic = _topicController.text;
                          if (topic.isNotEmpty) {
                            subscribeToTopic(topic);
                            logger.d('Subscribed to topic: $topic');
                          }
                        },
                        child: Text(
                          'Subscribe',
                          style: Style.textStyles.primary(
                            color: Style.colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                    3.w.wGap,
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final topic = _topicController.text;
                          final message = _messageController.text;
                          if (topic.isNotEmpty && message.isNotEmpty) {
                            publishMessage(topic, message);
                            logger.t('Published message to topic: $topic');
                          }
                          _messageController.clear();
                        },
                        child: Text(
                          'Publish',
                          style: Style.textStyles.primary(
                            color: Style.colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Style.colors.white,
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          messages[index],
                          style: Style.textStyles.primary(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: Style.colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
