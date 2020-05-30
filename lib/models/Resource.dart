
class Resource<T> {
  Status status;
  T data;
  String message;

  Resource(this.status, this.data, this.message);

  Resource.success(T this.data)
      : status = Status.SUCCESS;

  Resource.error(Status this.status, this.message,{this.data});

  Resource.loading({this.message})
  : status = Status.LOADING;

}

enum Status { SUCCESS, INTERNAL_SERVER_ERROR, GENERIC_ERROR, LOADING }
