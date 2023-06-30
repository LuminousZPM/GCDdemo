//
//  ViewController.m
//  GCD
//
//  Created by Luminous on 2023/6/29.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic ,assign) int count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/**
 * 同步执行 + 并发队列
 * 特点：在当前线程中执行任务，不会开启新线程，执行完一个任务，再执行下一个任务。
 */
- (IBAction)syncConcurrent:(id)sender {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"syncConcurrent---begin");

    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_sync(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });

    dispatch_sync(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });

    dispatch_sync(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });

    NSLog(@"syncConcurrent---end");
}

/**
 * 异步执行 + 并发队列
 * 特点：可以开启多个线程，任务交替（同时）执行。
 */
- (IBAction)asyncConcurrent:(id)sender {

    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncConcurrent---begin");

    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });

    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });

    dispatch_async(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });

    NSLog(@"asyncConcurrent---end");
}


/**
 * 同步执行 + 串行队列
 * 特点：不会开启新线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务。
 */
- (IBAction)syncSerial:(id)sender {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"syncSerial---begin");

    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);

    dispatch_sync(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    dispatch_sync(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    dispatch_sync(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });

    NSLog(@"syncSerial---end");
}


/**
 * 异步执行 + 串行队列
 * 特点：会开启新线程，但是因为任务是串行的，执行完一个任务，再执行下一个任务。
 */
- (IBAction)asyncSerial:(id)sender {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncSerial---begin");

    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);

    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    dispatch_async(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });

    NSLog(@"asyncSerial---end");
}

/**
 * 同步执行 + 主队列
 * 特点(主线程调用)：互等卡主不执行。
 * 特点(其他线程调用)：不会开启新线程，执行完一个任务，再执行下一个任务。
 */
- (IBAction)syncMain:(id)sender {

    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"syncMain---begin");

    dispatch_queue_t queue = dispatch_get_main_queue();

    dispatch_sync(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });

    dispatch_sync(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });

    dispatch_sync(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });

    NSLog(@"syncMain---end");
}

/**
 * 异步执行 + 主队列
 * 特点：只在主线程中执行任务，执行完一个任务，再执行下一个任务
 */
- (IBAction)asyncMain:(id)sender {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncMain---begin");

    dispatch_queue_t queue = dispatch_get_main_queue();

    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });

    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });

    dispatch_async(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });

    NSLog(@"asyncMain---end");
}

/**
 * 线程间通信
 */
- (IBAction)communication:(id)sender  {
    // 获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();

    dispatch_async(queue, ^{
        // 异步追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程

        // 回到主线程
        dispatch_async(mainQueue, ^{
            // 追加在主线程中执行的任务
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        });
    });
}

- (IBAction)dispatch_applyAction:(id)sender {
    //    第一个参数是重复次数
    //    第二个参数为追加任务的队列Dispatch Queue
    //    第三个参数为追加的Block （任务）
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);

    NSLog(@"begin");

    dispatch_apply(6, queue, ^(size_t index) {
        NSLog(@"%zd, %@", index, [NSThread currentThread]);
    });

    NSLog(@"end");

}
- (IBAction)dispatch_group_notifyAction:(id)sender {
    //    dispatch_group_create函数生成dispatch_group_t类型的Dispatch Group
    //    dispatch_group_async函数
    //    第一个参数是指定的group
    //    第二个参数是队列，将第三个参数Block（任务）添加在这个队列中
    //    第三参数是block，任务
    //    dispatch_group_notify函数
    //    第一个参数指定为要监视的Dispatch Group
    //    第二个参数为要追加结束处理的队列
    //    第三个参数是结束处理
    //    当追加到第一个参数Dispatch Group的全部任务执行结束时，将第三个参数的Block追加到第二个参数的DIspatch Queue中

    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];

        NSLog(@"1, %@", [NSThread currentThread]);

    });

    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2, %@", [NSThread currentThread]);
    });

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });

    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3, %@", [NSThread currentThread]);
    });
    //等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    //        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    //        NSLog(@"end");

}

/**
 使用 GCD 如何实现这个需求：A、B、C 三个任务并发，完成后执行任务 D。
 需要解决这个首先就需要了解dispatch_group_enter 和 dispatch_group_leave。

 dispatch_group_enter 标志着一个任务追加到 group，执行一次，相当于 group 中未执行完毕任务数+1
 dispatch_group_leave 标志着一个任务离开了 group，执行一次，相当于 group 中未执行完毕任务数-1。
 当 group 中未执行完毕任务数为0的时候，才会使dispatch_group_wait解除阻塞，以及执行追加到dispatch_group_notify中的任务。

 */
- (IBAction)dispatch_group_enter_leaveAction:(id)sender {
    //    dispatch_group_enter标志着要有一个任务追加到group中，执行一次，相当于group中未执行完毕的任务数+1
    //    dispatch_group_leave标志着有一个任务离开了group，执行一次，相当于group中未执行完毕的任务数-1
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_enter(group);
    [self requestA:^{  NSLog(@"---执行A任务结束---");  dispatch_group_leave(group);  }];

    dispatch_group_enter(group);
    [self requestB:^{  NSLog(@"---执行B任务结束---");  dispatch_group_leave(group);  }];

    dispatch_group_enter(group);
    [self requestC:^{  NSLog(@"---执行C任务结束---");  dispatch_group_leave(group);  }];

    dispatch_group_notify(group, globalQueue, ^{
        [self requestD:^{
            NSLog(@"---执行D任务结束---");
        }];
    });


}

- (void)requestA:(void(^)(void))block{
  NSLog(@"---执行A任务开始---");
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
  block();
  });
}
- (void)requestB:(void(^)(void))block{
  NSLog(@"---执行B任务开始---");
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
  block();
  });
}
- (void)requestC:(void(^)(void))block{
  NSLog(@"---执行C任务开始---");
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
  block();
  });

}
- (void)requestD:(void(^)(void))block{
  NSLog(@"---执行D任务开始---");
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
  block();
  });
}

//=============================================

- (IBAction)dispatch_barrier_asyncAction:(id)sender {
    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{

        [NSThread sleepForTimeInterval:2];
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });

    dispatch_async(queue, ^{

        [NSThread sleepForTimeInterval:2];
        NSLog(@"任务2---%@", [NSThread currentThread]);
    });

    dispatch_async(queue, ^{

        [NSThread sleepForTimeInterval:2];
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });

    dispatch_barrier_async(queue, ^{
        NSLog(@"barrier   %@", [NSThread currentThread]);
    });

    dispatch_async(queue, ^{

        [NSThread sleepForTimeInterval:2];
        NSLog(@"任务4---%@", [NSThread currentThread]);
    });

    dispatch_async(queue, ^{

        [NSThread sleepForTimeInterval:2];
        NSLog(@"任务5---%@", [NSThread currentThread]);
    });

    dispatch_async(queue, ^{

        [NSThread sleepForTimeInterval:2];
        NSLog(@"任务6---%@", [NSThread currentThread]);
    });

}
- (IBAction)DispatchSemaphoreAction:(id)sender {
    //    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    //    创建一个Semaphore并初始化信号的总量
    //    dispatch_semaphore_signal：发送一个信号，信号量+1
    //    dispatch_semaphore_wait：信号量减1，信号总量小于0时会一直等待（阻塞所在线程），否则就可以正常运行


    //   执行顺序如下：
    //    semaphore初始创建时计数为0
    //   异步执行将任务添加到队列之后，不做等待，直接执行dispatch_semaphore_wait方法，semaphore-1，此时semaphore < 0，当前线程阻塞，进入等待状态。
    //    然后异步任务开始执行。当执行到dispatch_semaphore_signal之后，semaphore + 1，此时semaphore 为0，正在被阻塞的线程（主线程）恢复继续执行。
    //    最后打印num


    NSLog(@"begin %@", [NSThread currentThread]);

    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    __block int num = 0;

    dispatch_async(queue, ^{
        NSLog(@"%@", [NSThread currentThread]);
        num = 10;
        dispatch_semaphore_signal(semaphore);
    });

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"%d -- %@", num, [NSThread currentThread]);

}

- (IBAction)initTicketStatusNotSafe:(id)sender {
    NSLog(@"begin, %@", [NSThread currentThread]);  //当前线程

    _count = 20;
    dispatch_queue_t queueA = dispatch_queue_create("A", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queueB =  dispatch_queue_create("B", DISPATCH_QUEUE_CONCURRENT);

    __weak id weakSelf = self;

    dispatch_async(queueA, ^{
        [weakSelf saleTicketNotSafe];
    });

    dispatch_async(queueB, ^{
        [weakSelf saleTicketNotSafe];
    });

}

- (void)saleTicketNotSafe {
    while (1) {
        if (_count > 0) {  //有票，继续卖

            self.count--;

            NSLog(@"剩余票数%d， 窗口%@", _count, [NSThread currentThread]);
            [NSThread sleepForTimeInterval:0.2];
        } else {
            NSLog(@"门票已全卖完");
            break;
        }
    }
}
- (IBAction)initTicketStatusSafe:(id)sender {
    NSLog(@"begin, %@", [NSThread currentThread]);  //当前线程

    _semaphore = dispatch_semaphore_create(1);

    //count = 20;
    _count = 20;
    dispatch_queue_t queueA = dispatch_queue_create("A", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queueB =  dispatch_queue_create("B", DISPATCH_QUEUE_CONCURRENT);

    __weak id weakSelf = self;

    dispatch_async(queueA, ^{
        [weakSelf saleTicketSafe];
    });

    dispatch_async(queueB, ^{
        [weakSelf saleTicketSafe];
    });

}

- (void)saleTicketSafe {
    while (1) {

        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);

        if (_count > 0) {  //有票，继续卖
            //count--;
            self.count--;
            NSLog(@"剩余票数%d， 窗口%@", _count, [NSThread currentThread]);
            [NSThread sleepForTimeInterval:0.2];

            dispatch_semaphore_signal(_semaphore);

        } else {
            NSLog(@"门票已全卖完");
            dispatch_semaphore_signal(_semaphore);
            break;
        }
    }
}


@end
