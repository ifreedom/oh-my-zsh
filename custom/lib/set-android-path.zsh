if [ -d "/opt/android-sdk" ]; then
	export PATH=$PATH:/opt/android-sdk/platform-tools:/opt/android-sdk/tools
fi
if [ -d "/opt/android-ndk" ]; then
	export PATH=$PATH:/opt/android-ndk
fi
