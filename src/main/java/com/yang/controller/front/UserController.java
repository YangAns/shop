package com.yang.controller.front;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yang.bean.EmailCode;
import com.yang.bean.User;
import com.yang.service.EmailCodeService;
import com.yang.service.UserService;
import com.yang.utils.DataGridViewResult;
import com.yang.utils.SendMail;
import com.yang.utils.SystemConstant;
import com.yang.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

/**
 * 前台用户
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private SendMail sendMail;
    @Autowired
    private EmailCodeService emailCodeService;


    /**
     * 后台用户列表展示
     * 查询用户列表
     *
     * @param userVo
     * @return
     */
    @ResponseBody
    @RequestMapping("/list")
    public DataGridViewResult list(UserVo userVo) {
        PageHelper.startPage(userVo.getPage(), userVo.getLimit());
        List<User> userList = userService.findUserList(userVo);
        PageInfo<User> pageInfo = new PageInfo<>(userList);
        System.out.println(pageInfo);
        return new DataGridViewResult(pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 修改用户
     *
     * @param user
     * @return
     */
    @RequestMapping("/adminUpdateUser")
    @ResponseBody
    public Map<String, Object> adminUpdateUser(User user) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (userService.updateUser(user) > 0) {
            map.put(SystemConstant.SUCCESS, true);//成功
            map.put(SystemConstant.MESSAGE, "修改成功");
        } else {
            map.put(SystemConstant.SUCCESS, false);//失败
            map.put(SystemConstant.MESSAGE, "修改失败");
        }
        return map;
    }

    /**
     * 后台删除用户
     *
     * @param id
     * @return
     */
    @RequestMapping("/deleteById")
    @ResponseBody
    public Map<String, Object> deleteById(int id) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (userService.deleteUserById(id) > 0) {
            map.put(SystemConstant.SUCCESS, true);//成功
            map.put(SystemConstant.MESSAGE, "删除成功");
        } else {
            map.put(SystemConstant.SUCCESS, false);//失败
            map.put(SystemConstant.MESSAGE, "删除失败");
        }
        return map;
    }
    //------------用户注册的实现-----------------
    /**
     * 去到前台注册页面
     *
     * @return
     */
    @RequestMapping("/toReg")
    public String toReg() {
        return "front/register";
    }

    /**
     * 执行用户注册
     *
     * @param user
     * @param model
     * @return
     */
    @Transactional
    @RequestMapping("/exReg")
    @ResponseBody
    public Map<String,Object> exReg(User user, String code, Model model) {
        HashMap<String, Object> map = new HashMap<>();
        EmailCode emailCode = emailCodeService.findEmailCodeByEmail(user.getEmail());
        if(emailCode==null){
            map.put(SystemConstant.MESSAGE,"emailCodeError");
        }else{
            if(!code.equals(emailCode.getCode())){
                map.put(SystemConstant.MESSAGE,"codeError");
            }else{
                userService.addUser(user);
                map.put(SystemConstant.MESSAGE,"success");
            }
        }
        return map;
    }

    /**
     * 用户注册发送验证码
     */
    @RequestMapping("/regSendCode")
    @ResponseBody
    public Map<String, Object> regSendCode(String email) throws Exception {
        System.out.println("email-->"+email);
        Map<String, Object> map = new HashMap<>();
        //随机生成六位0-9的6位正整数作为验证码
        keepEmailCode(email);
        map.put(SystemConstant.MESSAGE, "验证码发送成功");
        return map;
    }
    //------------用户登录的实现-----------------

    /**
     * 去到前台登录页面
     *
     * @return
     */
    @RequestMapping("/toLogin")
    public String toLogin() {
        return "front/login";
    }

    /**
     * 执行用户登录
     *
     * @return
     */
    @RequestMapping("/exLogin")
    @ResponseBody
    public Map<String, Object> exLogin(String userName, String password, HttpSession session) {
        Map<String, Object> map = new HashMap<String, Object>();
        User u = userService.login(userName, password);
        if (u != null) {
            session.setAttribute("user", u);
            map.put(SystemConstant.SUCCESS, true);
            map.put(SystemConstant.MESSAGE, "登录成功");
        } else {
            map.put(SystemConstant.SUCCESS, false);
            map.put(SystemConstant.MESSAGE, "用户名或密码错误");
        }
        return map;
    }

    /**
     * 前台用户退出
     *
     * @return
     */
    @RequestMapping("/loginOut")
    public String loginOut(HttpSession session) {
        session.removeAttribute("user");
        return "redirect:/index.html";
    }


    /**
     * 检查用户名是否重复
     *
     * @param userName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkName")
    public Map<String, Object> checkName(String userName) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (userService.findUserByName(userName) != null) {
            map.put(SystemConstant.EXIST, true);
            map.put(SystemConstant.MESSAGE, "用户名已被使用,请重新输入！");
        } else {
            map.put(SystemConstant.EXIST, false);
        }
        return map;
    }


    /**
     * 检查邮箱是否重复
     *
     * @param email
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkEmail")
    public Map<String, Object> checkEmail(String email) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (userService.findUserByEmail(email) != null) {
            map.put(SystemConstant.EXIST, true);
            map.put(SystemConstant.MESSAGE, "邮箱已被使用,请重新输入！");
        } else {
            map.put(SystemConstant.EXIST, false);
        }
        return map;
    }


    /**
     * 前台用户个人中心
     *
     * @param model
     * @param session
     * @return
     */
    @RequestMapping("/userCenter")
    public String userCenter(Model model, HttpSession session) {
        //取到session里的值
        User u = (User) session.getAttribute("user");
        if (u != null) {
            User user = userService.findUserById(u.getId());
            model.addAttribute("user", user);
            return "front/front_user/showUserCenter";
        } else {
            return "redirect:/user/toLogin";
        }
    }


    /**
     * 前台用户修改
     *
     * @param user
     * @return
     */
    @RequestMapping("/updateUser")
    public String updateUser(User user, HttpSession session) {
        User u = (User) session.getAttribute("user");
        if (u != null) {
            user.setId(u.getId());
            userService.updateUser(user);
            return "redirect:/user/userCenter";
        } else {
            return "redirect:/user/toLogin";
        }
    }

    /**
     * 跳转到修改密码
     *
     * @return
     */
    @RequestMapping("/updatePwd")
    public String updatePwd(HttpSession session) {
        User u = (User) session.getAttribute("user");
        if (u != null) {
            return "front/updpassword";
        } else {
            return "redirect:/user/toLogin";
        }
    }


    /**
     * 验证旧密码
     *
     * @return
     */
    @RequestMapping("/vanOldPwd")
    @ResponseBody
    public Map<Object, Object> vanOldPwd(String oldpwd, HttpSession session) {
        Map<Object, Object> map = new HashMap<>();
        User u = (User) session.getAttribute("user");
        if (u.getUserName() == null) {
            map.put(SystemConstant.MESSAGE, "sessionError");
        } else if (oldpwd == null || oldpwd == "" || oldpwd.equals("")) {
            map.put(SystemConstant.MESSAGE, "error");
        } else {
            if (oldpwd.equals(u.getPassword())) {
                map.put(SystemConstant.MESSAGE, "true");
            } else {
                map.put(SystemConstant.MESSAGE, "false");
            }
        }
        return map;
    }


    /**
     * 执行修改密码
     *
     * @return
     */
    @RequestMapping("/exUpdatePwd")
    @ResponseBody
    public Map<Object, Object> exUpdatePwd(User user, HttpSession session) {
        Map<Object, Object> map = new HashMap<>();
        User u = (User) session.getAttribute("user");
        user.setId(u.getId());
        System.out.println("新密码" + user.getPassword());
        if (u.getUserName() != null) {
            if (userService.updateUser(user) > 0) {
                map.put(SystemConstant.SUCCESS, true);
                map.put(SystemConstant.MESSAGE, "密码修改成功，请退出使用新密码登录");
                session.removeAttribute("user");
            } else {
                map.put(SystemConstant.SUCCESS, false);
                map.put(SystemConstant.MESSAGE, "密码修改失败");
            }

        } else {
            map.put(SystemConstant.MESSAGE, "新密码错误");
        }
        return map;
    }

    //改变用户状态
    @RequestMapping("/changeUserStatus")
    @ResponseBody
    public Map<Object, Object> changeUserStatus(int id, int status) {
        Map<Object, Object> map = new HashMap<>();
        if (userService.changeUserStatus(id, status) > 0) {
            map.put(SystemConstant.SUCCESS, true);
        } else {
            map.put(SystemConstant.SUCCESS, false);
        }
        return map;
    }


    //------------忘记密码的实现-----------------

    /**
     * 跳转到忘记密码页面
     *
     * @return forget.jsp
     */
    @RequestMapping(value = "/forgetPwd")
    public String forgetPwd() {
        return "front/forgetPwd";
    }


    /**
     * 忘记密码时发送验证码
     */
    @RequestMapping("/sendCode")
    @ResponseBody
    public Map<String, Object> forget(String email) throws Exception {
        Map<String, Object> map = new HashMap<>();
        User userByEmail = userService.findUserByEmail(email);
        System.out.println(userByEmail);
        if (userByEmail == null) {
            map.put(SystemConstant.EXIST, false);
            map.put(SystemConstant.MESSAGE, "该邮箱不存在，请重新输入");
        } else {
            keepEmailCode(email);
            map.put(SystemConstant.EXIST, true);
            map.put(SystemConstant.MESSAGE, "验证码发送成功");
        }
        return map;
    }

    /**
     * 找回密码
     *
     * @param email
     * @param password
     * @param code
     * @return
     */
    @RequestMapping("/updatePwdByEmail")
    @ResponseBody
    public Map<String, Object> updatePwdByEmail(String email, String password, String code) {
        Map<String, Object> map = new HashMap<>();
        EmailCode emailCode = emailCodeService.findEmailCodeByEmail(email);
        if (emailCode == null) {
            map.put(SystemConstant.SUCCESS, "emailCodeError");
            map.put(SystemConstant.MESSAGE, "请先获取验证码");
        } else {
            String existCode = emailCode.getCode();
            if (!code.equals(existCode)) {
                map.put(SystemConstant.SUCCESS, "codeError");
                map.put(SystemConstant.MESSAGE, "验证码不正确");
            } else {
                if (userService.updatePasswordByEmail(password, email) > 0) {
                    map.put(SystemConstant.SUCCESS, "true");
                    map.put(SystemConstant.MESSAGE, "密码重置成功");
                } else {
                    map.put(SystemConstant.SUCCESS, "false");
                    map.put(SystemConstant.MESSAGE, "密码重置失败");
                }
            }
        }
        return map;
    }

    //用户头像
    @RequestMapping("/findUserPicById")
    @ResponseBody
    public User findUserPicById(HttpSession session) {
        User u = (User) session.getAttribute("user");
        return userService.findUserPicById(u.getId());
    }

    //发送验证码并且保存在EmailCode表中
    private void keepEmailCode(String email) throws Exception {
        StringBuilder code = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < 6; i++) {
            code.append(random.nextInt(10));
        }
        //发送邮件
        sendMail.sendCode(email, code.toString());
        //用emailcode表保存验证码
        EmailCode existCode = emailCodeService.findEmailCodeByEmail(email);
        //插入验证码
        if (existCode == null) {
            EmailCode emailCode = new EmailCode();
            emailCode.setEmail(email);
            emailCode.setCode(code.toString());
            emailCodeService.insetEmailCode(emailCode);
        } else {
            //更新验证码
            emailCodeService.updateEmailCodeByEmail(code.toString(), email);
        }
    }
}
