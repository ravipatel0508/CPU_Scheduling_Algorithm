

String fcfsString = '''\n
    • First Come First Serve (FCFS) is an operating system scheduling algorithm that automatically executes queued requests and processes in order of their arrival.\n
    • It is the easiest and simplest CPU scheduling algorithm.\n
    • In this type of algorithm, processes which requests the CPU first get the CPU allocation first.\n 
    • This is managed with a FIFO queue. \n
    • It supports non-preemptive and pre-emptive scheduling algorithm.\n 
    • Jobs are always executed on a first-come, first-serve basis.\n
    • It is easy to implement and use.\n
    • This method is poor in performance, and the general wait time is quite high.\n
    • First come first serve (FCFS) scheduling algorithm simply schedules the jobs according to their arrival time.\n 
    • FCFS scheduling may cause the problem of starvation if the burst time of the first process is the longest among all the jobs.\n\n
    • The working of FCFS alogrithm is as follows:\n
    As the process enters the ready queue, its PCB (Process Control Block) is linked with the tail of the queue and, when the CPU becomes free, it should be assigned to the process at the beginning of the queue.\n\n  
    • Some Disadvantages of this algorithm are as follows: - \n
    1. The scheduling method is non preemptive, the process will run to the completion.\n 
    2.  Due to the non-preemptive nature of the algorithm, the problem of starvation  may occur.\n 
    3. Although it is easy to implement, but it is poor in performance since the average waiting time is higher as compare to other scheduling algorithms.\n ''';

String srtfString = '''\n    • This Algorithm is the preemptive version of SJF scheduling. \n
    • In SRTF, the execution of the process can be stopped after certain amount of time. \n
    • Once all the processes are available in the ready queue, No preemption will be done and the algorithm will work as SJF scheduling. \n
    • The context of the process is saved in the Process Control Block when the process is removed from the execution and the next process is scheduled. \n 
    • This PCB is accessed on the next execution of this process. \n
    • It is associated with each job as a unit of time to complete. \n
    • This algorithm method is helpful for batch-type processing, where waiting for jobs to complete is not critical. \n
    • It can improve process throughput by making sure that shorter jobs are executed first, hence possibly have a short turnaround time. \n 
    • It improves job output by offering shorter jobs, which should be executed first, which mostly have a shorter turnaround time. \n\n
    • Working of this algorithm :- \n 
         At the arrival of every process, the short term scheduler schedules the process with the least remaining burst time among the list of available processes and the running process. \n\n 
    • Some Disadvantages of this algorithm are as follows: -  \n
    1. It can not be implemented practically since burst time of the processes can not be known in advance.\n
    2. It leads to starvation for processes with larger burst time. \n
    3. Priorities can not be set for the processes. \n
    4. Processes with larger burst time have poor response time. \n
 \n ''';

String tlfcfsString = ''' \n• Two-level scheduling is a computer science term to describe a method to more efficiently perform process scheduling that involves swapped out processes. \n
   • With straightforward Round-robin scheduling, every time a context switch occurs, a process would need to be swapped in (because only the least recently used processes are swapped in). \n
   • Choosing randomly among the processes would diminish the probability to lesser percentage. \n
   • If that occurs, then obviously a process also needs to be swapped out. \n
   • Swapping in and out of is costly, and the scheduler would waste much of its time doing unneeded swaps. \n
   • That is where two-level scheduling enters the picture. \n
   • It uses two different schedulers, one lower-level scheduler which can only select among those processes in memory to run. \n
   • That scheduler could be a FCFS scheduler.
   • The other scheduler is the higher-level scheduler whose only concern is to swap in and swap out processes from memory. \n
   • It does its scheduling much less often than the lower-level scheduler since swapping takes so much time. \n
   • Thus, the higher-level scheduler selects among those processes in memory that have run for a long time and swaps them out. \n
   • They are replaced with processes on disk that have not run for a long time. \n
   • Exactly how it selects processes is up to the implementation of the higher-level scheduler. \n \n
   • A compromise has to be made involving the following variables: \n
   1. Response time: A process should not be swapped out for too long. Then some other process (or the user) will have to wait needlessly long. If this variable is not considered resource starvation may occur and a process may not complete at all. \n
   2. Size of the process: Larger processes must be subject to fewer swaps than smaller ones because they take longer time to swap. Because they are larger, fewer processes can share the memory with the process. \n
   3. Priority: The higher the priority of the process, the longer it should stay in memory so that it completes faster. \n\n
   • Thus, it works similar to FCFS, only it has a high priority queue and a low priority queue. \n
   • Processes in the High Priority Queue are preferred when executing a process from the backlog and low priority processes are interrupted by new high priority processes.''';

String sjfString = ''' \n• Shortest job first (SJF) or shortest job next, is a scheduling policy that selects the waiting process with the smallest execution time to execute next. SJN is a non-preemptive algorithm. \n
   • Shortest Job first has the advantage of having a minimum average waiting time among all scheduling algorithms. \n
   • It is a Greedy Algorithm. \n
   • It may cause starvation if shorter processes keep coming. This problem can be solved using the concept of ageing. \n
   • It is practically infeasible as Operating System may not know burst time and therefore may not sort them. \n
   • While it is not possible to predict execution time, several methods can be used to estimate the execution time for a job, such as a weighted average of previous execution times. \n
   • SJF can be used in specialized environments where accurate estimates of running time are available. \n\n
   • Algorithm: \n
   1. Sort all the process according to the arrival time. \n
   2. Then select that process which has minimum arrival time and minimum Burst time. \n
   3. After completion of process make a pool of process which after till the completion of previous process and select that process among the pool which is having minimum Burst time. \n\n
   •  How to compute below times in SJF using a program? \n
   1. Completion Time: Time at which process completes its execution. \n
   2. Turn Around Time: Time Difference between completion time and arrival time. Turn Around Time = Completion Time – Arrival Time\n
   3. Waiting Time(W.T): Time Difference between turn around time and burst time. \n
   4. Waiting Time = Turn Around Time – Burst Time\n''';

String rrString = '''\n•Round Robin(RR) scheduling algorithm is mainly designed for time-sharing systems. This algorithm is similar to FCFS scheduling, but in Round Robin(RR) scheduling, preemption is added which enables the system to switch between processes.\n
   • A fixed time is allotted to each process, called a quantum, for execution.\n
   • Once a process is executed for the given time period that process is preempted and another process executes for the given time period.\n
   • Context switching is used to save states of preempted processes.\n
   • This algorithm is simple and easy to implement and the most important is thing is this algorithm is starvation-free as all processes get a fair share of CPU.\n
   • It is important to note here that the length of time quantum is generally from 10 to 100 milliseconds in length.\n\n

   Some important characteristics of the Round Robin(RR) Algorithm are as follows:\n
   • Round Robin Scheduling algorithm resides under the category of Preemptive Algorithms\n
   • This algorithm is one of the oldest, easiest, and fairest algorithm.\n
   •This Algorithm is a real-time algorithm because it responds to the event within a specific time limit.\n
   • In this algorithm, the time slice should be the minimum that is assigned to a specific task that needs to be processed. Though it may vary for different operating systems.\n
   • This is a hybrid model and is clock-driven in nature.\n
   • This is a widely used scheduling method in the traditional operating system.''';