class CrudPostitPresenter{
  int counter = 0;

  final ICrudPostitController iCrudPostitPresenter;

  CrudPostitPresenter(this.iCrudPostitPresenter);

  increment(){
    counter++;

    iCrudPostitPresenter.update();
  }
}

abstract class ICrudPostitController{
  void update();
}