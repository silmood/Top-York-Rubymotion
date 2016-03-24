
public void setImageWithGlide(
    android.widget.ImageView imageView,
    java.lang.String url,
    android.content.Context context){

    com.bumptech.glide.Glide.with(context)
        .load((java.lang.String) url)
        .centerCrop()
        .dontAnimate()
        .into(imageView);
  }