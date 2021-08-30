package play;

public class ThisSuperTest {

    public static void main(String args[]){
        //创建Cow对象的时候，会在Mammal的构造方法里调用this.reportWeight()，这里会显示什么
        Cow cow = new Cow();

        System.out.println();

        //这里调用，会显示什么
        cow.speak();
    }
}

class Mammal{
    int weight;

    Mammal(){
        System.out.println("Mammal() called");
        this.weight = 100;
    }

    Mammal(int weight){
        this();   //调用自己的另一个构造函数
        System.out.println("Mammal(int weight) called");
        this.weight = weight;

        //这里访问属性，是自己的weight
        System.out.println("this.weight in Mammal : " + this.weight);

        //这里的speak()调用的是谁，会显示什么数值
        this.speak();
    }

    void speak(){
        System.out.println("Mammal's weight is : " + this.weight);
    }
}


class Cow extends Mammal{
    int weight = 300;

    Cow(){
        super(200);   //调用父类的构造函数
    }

    void speak(){
        System.out.println("Cow's weight is : " + this.weight);
        System.out.println("super.weight is : " + super.weight);
    }
}