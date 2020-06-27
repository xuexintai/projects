package cn.xue.crud.test;

import cn.xue.crud.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations =  { "classpath:applicationContext.xml",
        "classpath:WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcText {
    //传入SPringMVC的IOC
    @Autowired
    WebApplicationContext context;

    //虚拟MVC请求，获取到处理结果
    MockMvc mockMvc;
    @Before
    public void initMockMvc(){
        MockMvcBuilders.webAppContextSetup(context).build();
    }
    @Test
    public void pageTest() throws Exception {
        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1"))
                .andReturn();

        //请求成功之后。请求域中会有pageInfo，我们可以取出pageInfo进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo)request.getAttribute("pageInfo");
       // System.out.println("当前页码"+pi.getPageNum());
        System.out.println(pi.getPages());
        System.out.println(pi.getTotal());
        int[] nums = pi.getNavigatepageNums();
        for (int i: nums) {
            System.out.println(i);
        }
        //获取员工数据
        List<Employee> list = pi.getList();
        for (Employee e:list) {
            System.out.println(e.getdId()+e.getDepartment().getDeptId());
        }
    }

}
