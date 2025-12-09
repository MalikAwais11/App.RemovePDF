# Keep PDFBox classes
-keep class com.tom_roush.** { *; }

# Keep Gemalto JP2 Decoder (JPEG 2000 support)
-keep class com.gemalto.jp2.** { *; }
-dontwarn com.gemalto.jp2.**

# Keep Google Play Core SplitInstall classes
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Keep Bouncy Castle Security classes
-keep class org.bouncycastle.** { *; }
-dontwarn org.bouncycastle.**

# Keep Java Naming classes (used in Bouncy Castle)
-keep class javax.naming.** { *; }
-dontwarn javax.naming.**

# Prevent stripping of native libraries
-keep class org.apache.commons.** { *; }
-dontwarn org.apache.commons.**

# Keep Flutter plugin classes
-keep class io.flutter.** { *; }

# Keep all annotations
-keepattributes *Annotation*

# Keep public and protected members
-keep class * {
    public protected *;
}

