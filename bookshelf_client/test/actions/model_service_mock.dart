import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/services/model_service.dart';

class ModelServiceMock implements ModelService {

  List<Model> modelHistory = [];

  @override
  Model get model => modelHistory.last;


  @override
  set model(Model _model) {
    modelHistory.add(_model);
  }
}