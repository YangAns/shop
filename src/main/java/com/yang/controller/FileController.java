package com.yang.controller;

import com.yang.utils.UUIDUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.boot.system.ApplicationHome;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 处理文件上传
 */
@RestController
@RequestMapping("/file")
public class FileController {
    /**
     * 文件上传
     * @param file
     * @return
     */
    @RequestMapping("/uploadFile")
    public Map<String,Object > uploadFile(MultipartFile file, HttpServletRequest request){
        //创建Map集合保存返回的JSON数据
        Map<String,Object> map = new HashMap<String,Object>();
        //判断是否有选中文件
        if(!file.isEmpty()){
            String filePath = System.getProperty("user.dir");
            String path=request.getSession().getServletContext().getRealPath(filePath+"/upload");

            System.out.println("path:"+path);

            //获取源文件的名称
            String oldFileName = file.getOriginalFilename();
            System.out.println("oldFileName:"+oldFileName);
            //获取文件的后缀名
            String extension = FilenameUtils.getExtension(oldFileName);
            System.out.println("extension:"+extension);
            //重命名旧文件
            String newFileName = UUIDUtils.randomUUID()+"."+extension;
            System.out.println("newFileName:"+newFileName);
            //为了解决同一个文件夹下文件过多的问题，使用日期作为文件夹管理
            String datePath = new SimpleDateFormat("yyyyMMdd").format(new Date());
            //组装最终的文件名
            String finalName = datePath + "/" + newFileName;
            System.out.println("finalName:"+finalName);
            //创建文件对象
            //参数1：文件上传的地址 参数2：文件名称
            File dest = new File(path,finalName);
            System.out.println("dest.getAbsolutePath():"+dest.getAbsolutePath());
            System.out.println("dest.getParentFile():"+dest.getParentFile());
            System.out.println("dest.getParent:"+dest.getParent());
            System.out.println("dest.getPath():"+dest.getPath());
            //判断该文件夹是否存在，不存在则创建文件夹
            if(!dest.getParentFile().exists()){
                dest.getParentFile().mkdirs();//创建文件夹
            }
            try {
            //进行文件上
                file.transferTo(dest);
                map.put("code",0);//状态码
                map.put("msg","上传成功");//执行消息
                Map<String,Object> dataMap = new HashMap<String,Object>();
                dataMap.put("src","/shop/upload/"+finalName);
                map.put("data",dataMap);//文件数据
                map.put("imagePath",finalName);//隐藏域的值，只保留日期文件夹+重命名后的文件名
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return map;
    }
}
