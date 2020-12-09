# Setup Environment
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
ccache -M 20G
export PATH=$(pwd)/gcc/bin:$PATH

# Build Settings
CONF=j4primelte_defconfig
ARCH=arm64
OUTPUT=$(pwd)/out
COMP=aarch64-linux-android-
COMP2=arm-linux-gnueabi-

# Export User Name and Host Name
export KBUILD_BUILD_USER=Batu33TR
export KBUILD_BUILD_HOST=AmazonWebServices

# Delete Output
rm -rf $OUTPUT

# Write .config
make O=$OUTPUT \
ARCH=$ARCH \
SUBARCH=$ARCH \
CROSS_COMPILE=$COMP \
CROSS_COMPILE_ARM32=$COMP2 \
$CONF

# Build Kernel
make O=$OUTPUT \
ARCH=$ARCH \
SUBARCH=$ARCH \
CROSS_COMPILE=$COMP \
CROSS_COMPILE_ARM32=$COMP2 \
-j$(nproc --all)

exit
