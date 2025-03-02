// Mocks generated by Mockito 5.4.5 from annotations
// in quize_app/test/src/data/repositories/subject_repository_impl/subject_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:quize_app/src/data/data_source/online_data_source/subject_online_data_source/subject_online_data_source.dart'
    as _i3;
import 'package:quize_app/src/data/mappers/subject_mapper.dart' as _i5;
import 'package:quize_app/src/data/model/response/subject_response_model/subject_response_model.dart'
    as _i2;
import 'package:quize_app/src/domain/entities/subject_entity.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeSubjectResponseModel_0 extends _i1.SmartFake
    implements _i2.SubjectResponseModel {
  _FakeSubjectResponseModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SubjectOnlineDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSubjectOnlineDataSource extends _i1.Mock
    implements _i3.SubjectOnlineDataSource {
  MockSubjectOnlineDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.SubjectResponseModel> getAllSubject() => (super.noSuchMethod(
        Invocation.method(
          #getAllSubject,
          [],
        ),
        returnValue: _i4.Future<_i2.SubjectResponseModel>.value(
            _FakeSubjectResponseModel_0(
          this,
          Invocation.method(
            #getAllSubject,
            [],
          ),
        )),
      ) as _i4.Future<_i2.SubjectResponseModel>);
}

/// A class which mocks [SubjectMapper].
///
/// See the documentation for Mockito's code generation for more information.
class MockSubjectMapper extends _i1.Mock implements _i5.SubjectMapper {
  MockSubjectMapper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i6.SubjectEntity> toSubjectEntity(
          _i2.SubjectResponseModel? subjectResponseModel) =>
      (super.noSuchMethod(
        Invocation.method(
          #toSubjectEntity,
          [subjectResponseModel],
        ),
        returnValue: <_i6.SubjectEntity>[],
      ) as List<_i6.SubjectEntity>);
}
