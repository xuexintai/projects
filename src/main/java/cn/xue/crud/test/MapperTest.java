package cn.xue.crud.test;

import cn.xue.crud.bean.Department;
import cn.xue.crud.bean.Employee;
import cn.xue.crud.bean.EmployeeExample;
import cn.xue.crud.dao.DepartmentMapper;
import cn.xue.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    @Test
    public void testCRUD(){
        System.out.println(departmentMapper);

        //插入部门
//        departmentMapper.insertSelective( new Department(1,"开发部"));
//        departmentMapper.insertSelective( new Department(2,"测试部"));

        //生成员工数据
     // employeeMapper.insertSelective(new Employee(1,"小王","M","1990303@qq.com",1));

        //批量插入员工，批量，使用可执行批量操作的sqlSession
//   EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i = 0;i<1000;i++){
//            String uid = UUID.randomUUID().toString().substring(0, 5)+i;
//            mapper.insertSelective(new Employee(i,uid,"M",uid+"@qq.com",1));
//        }
//          批量删除
//        for (int i = 0;i<1000;i++){
//          mapper.deleteByPrimaryKey(i);
//        }
      //  mapper.deleteByPrimaryKey(1);
//        mapper.deleteByPrimaryKey(1001);
        //查询
//        Employee employee = employeeMapper.selectByPrimaryKeyWithDept(1);
//        System.out.println(employee.getDepartment().getDeptName());
        System.out.println("执行完成");

    }
}
