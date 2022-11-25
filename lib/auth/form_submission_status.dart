abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {
  String result;
  SubmissionSuccess(this.result);
}

class SubmissionFailed extends FormSubmissionStatus {
   Object exception;

  SubmissionFailed(this.exception);
}