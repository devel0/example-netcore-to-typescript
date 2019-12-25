#!/bin/bash

#if [ "$DOTNET_ROOT" == "" ]; then
#	echo "specify DOTNET_ROOT env var"
#	exit 0
#fi

exdir=$(dirname `readlink -f "$0"`)

#rm -fr "$exdir"/src/bin "$exdir"/src/obj
dotnet build "$exdir"/src
# dotnet build "$exdir"/src /p:CopyLocalLockFileAssemblies=true

# follow required to allow ReinforcedTypings recognize some dll refs
# cp -f "$DOTNET_ROOT"/shared/Microsoft.AspNetCore.App/3.0.0/* "$exdir"/src/bin/Debug/netcoreapp3.0/

dstapi="$exdir/ClientApp/src/api-autogen/"
rm -fr "$dstapi"
mkdir -p "$dstapi"

DLL="$exdir/src/bin/Debug/netcoreapp3.0/example-netcore-to-typescript.dll"

echo "---> DLL: $DLL"
echo

dotnet ~/.nuget/packages/reinforced.typings/1.5.6/tools/netcoreapp3.0/rtcli.dll \
    SourceAssemblies="$DLL" \
    ConfigurationMethod="example_netcore_to_typescript.ReinforcedTypingsConfiguration.Configure" \
    TargetDirectory="$dstapi" \
    Hierarchy="true"

echo
echo "---> destination api = $dstapi"
