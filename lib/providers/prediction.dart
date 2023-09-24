part of providers;

final predictionProvider =
    ChangeNotifierProvider((ref) => PredictionProvider(ref));

class PredictionProvider extends ChangeNotifier {
  Ref ref;
  Box<ResultAdapter>? result;
  PredictionProvider(this.ref) {
    init();
  }

  init() async {
    // initialize hive services
    // await Hive.initFlutter();
    // Hive.registerAdapter(ResultAdapterAdapter());
    // Hive.openBox<ResultAdapter>('results');
  }

  // prediction logic
  Future<String?> loadModel() async {
    try {
      String modelPath = 'assets/model/model_unquant.tflite';
      final response = await Tflite.loadModel(
        model: modelPath,
        labels: 'assets/model/labels.txt',
      );
      return response;
    } catch (e) {
      // Handle error
      return 'Model loading failed: $e';
    }
  }

  Future<List<dynamic>?> interpret(File image) async {
    try {
      int startTime = DateTime.now().millisecondsSinceEpoch;
      var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 6,
        threshold: 0.05,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      int endTime = DateTime.now().millisecondsSinceEpoch;
      print("Inference took ${endTime - startTime}ms");

      return recognitions;
    } catch (e) {
      // Handle error
      print('error: $e');
      // throw Exception(e);
      return [];
    }
  }
}
