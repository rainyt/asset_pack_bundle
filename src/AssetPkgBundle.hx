import haxe.macro.Context;
#if macro
import sys.FileSystem;
import sys.io.File;
import haxe.macro.Expr.Field;

/**
 * 资源分包实现，请注意，需要定义aab才会生效，具体请参考`README.md`文档
 */
class AssetPkgBundle {
	/**
	 * 分包处理
	 * @param assets 
	 * @return Array<Field>
	 */
	macro public static function split(assets:Array<String>):Array<Field> {
		var spistDir = Sys.getCwd() + "Export/android/bin/deps/asset_pack_name/src/main/assets";
		var dir = Sys.getCwd() + "Export/android/bin/app/src/main/assets";
		for (s in assets) {
			copyFile(dir + "/" + s, spistDir + "/" + s);
			removeDir(dir + "/" + s);
		}
		return Context.getBuildFields();
	}

	/**
	 * 删除文件夹
	 * @param file 
	 */
	public static function removeDir(file:String):Void {
		if (!FileSystem.exists(file))
			return;
		if (FileSystem.isDirectory(file)) {
			for (s in FileSystem.readDirectory(file)) {
				removeDir(file + "/" + s);
			}
			FileSystem.deleteDirectory(file);
		} else {
			FileSystem.deleteFile(file);
		}
	}

	/**
	 * 复制文件或者文件夹
	 * @param file 
	 * @param tofile 
	 */
	public static function copyFile(file:String, tofile:String):Void {
		if (!FileSystem.exists(file))
			return;
		if (FileSystem.isDirectory(file)) {
			FileSystem.createDirectory(tofile);
			for (s in FileSystem.readDirectory(file)) {
				copyFile(file + "/" + s, tofile + "/" + s);
			}
		} else {
			File.copy(file, tofile);
		}
	}
}
#end
