# Keep ExoPlayer classes used by just_audio
-keep class com.google.android.exoplayer2.** { *; }
-keep interface com.google.android.exoplayer2.** { *; }
-keep class com.google.common.** { *; }

# Keep flutter and just_audio method channels
-keep class io.flutter.embedding.engine.FlutterEngine { *; }
-keep class io.flutter.plugin.common.MethodChannel { *; }
-keep class com.ryanheise.just_audio.** { *; }
