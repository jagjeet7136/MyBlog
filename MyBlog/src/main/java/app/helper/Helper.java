package app.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {

	public static boolean deleteFile(String path) {
		boolean bool = false;

		try {
			File f = new File(path);
			bool = f.delete();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return bool;
	}

	public static boolean saveFile(InputStream is, String path) {
		boolean bool = false;
		System.out.println(path);
		try {
			byte b[] = new byte[is.available()];
			is.read(b);

			FileOutputStream f = new FileOutputStream(path);
//			System.out.println(path);
			f.write(b);
			f.flush();
			f.close();
			bool = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return bool;
	}
}
