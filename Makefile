PACKAGE = de.markusfisch.android.shadereditor

all: debug install start

debug:
	./gradlew assembleDebug

release: lint findbugs
	./gradlew assembleRelease

bundle: lint findbugs
	./gradlew bundleRelease

lint:
	./gradlew lintDebug

findbugs:
	./gradlew findBugs

infer: clean
	infer -- ./gradlew assembleDebug

install:
	adb $(TARGET) install -r app/build/outputs/apk/debug/app-debug.apk

start:
	adb $(TARGET) shell 'am start -n \
		$(PACKAGE).debug/$(PACKAGE).activity.SplashActivity'

uninstall:
	adb $(TARGET) uninstall $(PACKAGE).debug

meminfo:
	adb shell dumpsys meminfo $(PACKAGE).debug

images:
	svg/update.sh

clean:
	./gradlew clean
