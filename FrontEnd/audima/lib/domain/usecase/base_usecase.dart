import 'package:audima/data/network/failure.dart';
import 'package:dartz/dartz.dart';

//usecase is the gate which will connect viewodel with apicalls(data layer)
//so it has the input which comes from viewmodel and then pass it to the datalayer and get back the response from api then pass output back to the viewmodel
abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
