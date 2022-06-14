package com.yang.utils;


import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.UUID;

public class UUIDUtils {
    public static String randomUUID() {
       return UUID.randomUUID().toString().replace("-","");
    }
    @Test
    public void test2(){
        System.out.println(UUID.randomUUID().toString().replace("-",""));
        File file = new File("D:\\IdeaProjects\\毕设\\shop\\target\\shop-1.0-SNAPSHOT\\upload\\20211214\\061ff3a34a864bf884214236a69eb0c7.jpg");
        System.out.println("file.getAbsolutePath():"+file.getAbsolutePath());
        System.out.println("file.getParentFile():"+file.getParentFile());
        System.out.println("file.getParent:"+file.getParent());
        System.out.println("file.getPath():"+file.getPath());
        System.out.println();
        System.out.println(file.getName());
        System.out.println(file);
        System.out.println(file.isDirectory());
        System.out.println(file.isFile());
        System.out.println(file.exists());
        System.out.println(file.canRead());
        System.out.println(file.canWrite());
        System.out.println(file.isHidden());
    }
}
