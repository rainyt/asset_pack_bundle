# Assets pack bundle

## 配置分包资源
```haxe
#if (android && asset_pack_bundle)
// 提供需要分包的资源路径，但分包成功后，会自动移动到asset_pack_name目录下
@:build(AssetPkgBundle.split(["assets/map", "langpkg", "sound", "sub_assets", "sub_assets2"]))
#end
class Main {}
```