part of bc_screens;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends ConsumerState<HomeScreen> {
  bool processed = false;
  bool processing = false;
  File? _imageFile;
  List<dynamic>? predictions;
  Map<String, dynamic> result = {};

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
      }
    });
  }

  Future<void> _performImageDetection() async {
    if (_imageFile != null) {
      setState(() {
        processing = true;
      });

      await Future.delayed(const Duration(milliseconds: 1000));

      predictions =
          await ref.read(predictionProvider.notifier).interpret(_imageFile!);

      print('pred: $predictions');
      setState(() {
        for (var x = 0; x < predictions!.length; x++) {
          var max = predictions![0]["confidence"];
          result["confidence"] = max;
          result["label"] = predictions![0]["label"];
          if (max < predictions![x]["confidence"]) {
            max = predictions![x]["confidence"];
            result["confidence"] = max;
            result["label"] = predictions![x]["label"];
          }
        }
        processed = true;
        processing = false; // Set processing to false after inference
        // results = ResultAdapter.fromJson(result);
        // resultBox.add(results!);
        print(predictions);
        print(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.appTheme(context);
    final textTheme = CustomTextTheme.customTextTheme(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppHeader(
              title: "Ghana SL Detector",
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 18.0),
                  decoration: BoxDecoration(
                    color: appTheme.bgColor2,
                    borderRadius: BorderRadius.circular(12),
                    image: (_imageFile != null)
                        ? DecorationImage(
                            image: FileImage(_imageFile!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: (!processed && !processing && _imageFile == null)
                      ? Center(
                          child: Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: appTheme.primaryColor,
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
            (processing)
                ? Container(
                    margin: const EdgeInsets.symmetric(vertical: 25),
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      color: appTheme.primaryColor,
                    ),
                  )
                : (processed)
                    ? Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: appTheme.light,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Result: ",
                                ),
                                // (result["label"].split(" ")[1] ==
                                //         'malignant')
                                //     ? Text(
                                //         result["label"].split(" ")[1],
                                //         style: textTheme.labelSmall,
                                //       )
                                //     : Text(
                                //         result["label"].split(" ")[1],
                                //         style: textTheme.headlineSmall,
                                //       )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: CircularProgressIndicator(
                                    value: .5,
                                    backgroundColor: appTheme.bgColor2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      appTheme.primaryColor,
                                    ),
                                    strokeWidth: 8.0,
                                  ),
                                ),
                                Column(
                                  children: [
                                    const Text("Confidence: "),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${(.5 * 100).toInt()}%',
                                      style: textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(),
            const SizedBox(height: 10),
            (processed)
                ? CustomButton(
                    title: "Restart",
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.initRoute),
                  )
                : (_imageFile != null)
                    ? Column(
                        children: [
                          CustomButton(
                            color: appTheme.secondaryColor,
                            title: "Predict",
                            onPressed: () => _performImageDetection(),
                          ),
                          CustomButton(
                            color: appTheme.primaryColor,
                            title: "Re-uploaod Picture",
                            onPressed: () => _pickImage(ImageSource.gallery),
                          )
                        ],
                      )
                    : Column(
                        children: [
                          CustomButton(
                            color: appTheme.primaryColor,
                            icon: const Icon(
                              CupertinoIcons.camera,
                              size: 20,
                            ),
                            title: "Take a Picture",
                            onPressed: () => _pickImage(ImageSource.camera),
                          ),
                          CustomButton(
                            color: appTheme.uploadColor,
                            icon: const Icon(
                              CupertinoIcons.cloud_upload_fill,
                              size: 20,
                            ),
                            title: "Upload a Picture",
                            onPressed: () => _pickImage(ImageSource.gallery),
                          )
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String? title;
  final Color? color;
  final Icon? icon;
  final void Function()? onPressed;
  const CustomButton(
      {super.key, this.title, this.color, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final textTheme = CustomTextTheme.customTextTheme(context).textTheme;
    return SizedBox(
      width: 180,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(10),
            elevation: 0,
            backgroundColor: color,
          ),
          onPressed: onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                title.toString(),
                style: textTheme.labelMedium,
              )
            ],
          )),
    );
  }
}
