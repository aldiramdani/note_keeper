class Note{

  int _id;
  String _tittle;
  String _description;
  String _date;
  int _priority;

  Note(this._tittle,this._date,this._priority,[this._description]);

  Note.withID(this._id,this._tittle,this._date,this._priority,[this._description]);

  int get id => _id;
  String get tittle => _tittle;
  String get description => _description;
  int get priority => _priority;
  String get date => _date;

  set tittle(String newTittle){
    if(newTittle.length<=255){
      this._tittle = newTittle;
    }
  }

  set description(String newDescription){
    if(newDescription.length<=255){
      this._description = newDescription;
    }
  }

  set priority(int newPriority){
    if(newPriority >= 1 && newPriority<=2){
      this._priority = newPriority;
    }
  }

  set date(String newDate){
    this._date = date;
  }

  Map<String,dynamic>toMap(){
    var map = Map<String,dynamic>();

    if(id==null){
      map['id'] = _id;
    }
    map['tittle']=_tittle;
    map['description']=_description;
    map['priority']=_priority;
    map['date']=_date;

    return map;
  }

  //Extract note object from map object

  Note.fromMapObject(Map<String,dynamic>map){
    this._id = map['id'];
    this._tittle = map['tittle'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
  }

}
//[] mean optional