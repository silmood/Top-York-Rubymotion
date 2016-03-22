//Cast to serializable allowing that putExtra method work properly
public void addSerializableExtra(
    android.content.Intent intent,
    java.lang.String key,
    java.io.Serializable value){
    intent.putExtra(key, (java.io.Serializable)value);
  }

  public void addStringExtra(
      android.content.Intent intent,
      java.lang.String key,
      java.lang.String value){
      intent.putExtra(key, (java.lang.String)value);
    }