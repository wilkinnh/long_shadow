SIZE=$(find . -name "*.dart" | xargs cat | wc -c | xargs)
RED='\033[0;31m'
GREEN='\033[0;32m'
NO_COLOR='\033[0m' # No Color

if [ "$SIZE" -gt "5120" ]; then
	printf "🔥 ${RED}too large - $SIZE bytes${NO_COLOR}\n"
else
	printf "😎 ${GREEN}all good! - $SIZE bytes${NO_COLOR}\n"
fi