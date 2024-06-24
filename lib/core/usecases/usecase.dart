import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';

/// Base class for all usecases.
///
/// A use case represents a specific business logic operation and typically
/// interacts with repositories or other data sources to perform its task.
/// It takes a set of parameters and returns either a failure or the expected
/// result wrapped in an [Either] type.
abstract class UseCase<Type, Params> {
  /// Executes the use case with the given parameters.
  ///
  /// [params] is an instance of the parameters required by the use case.
  /// Returns a [Future] that completes with an [Either] containing either
  /// a [Failure] or the expected result of type [Type].
  Future<Either<Failure, Type>> call(Params params);
}

/// Represents an empty parameters class used for use cases that do not require
///  any specific parameters.
/// Typically used when defining a use case that performs an operation without
///  needing an external input.
class NoParams {}
