# Memory Forensic

## Challenges

The first challenge is how to get the file name, or more generally how to recover all the pointers in the memory dump, because the pointers values are the original memory address. Gladly the dump filenames contain the original start & end addresses, so we can calculate the original pointer address offset and add it to the reloaded buffer to retrieve the new pointers.


The biggest challenge is which entry attributes to use to verify current entry. To achieve it, I need to search all possible values or ranges of each attributes. For example, we need to know all the possible file `mode` values, like `rwx`. The file size `entry.size` should be a reasonable single file size in the target file system. To seriously and comprehensively filter out the invalid results, I should do some research to find if a system has any allowed file size, and if it does, what are the minimum and maximum number. (But for this homework, I simplified this task by choose only a few easy-to-check attributes and subjectively assume the propable boundaries, like 50G for file size).

In the end, I still could not perfectly achieve this goal. My output includes an invalid line which I have no easy way to filter

```
?r-x-----T 139819371840776 root     root              3 May 16  2018
-rw-rw-r--    1 osboxes  osboxes        1028 May 16  2018 /home/rodream/resume.log
```

The first line has valid file size and time, but the file name is actually an invalid pointer which points somewhere nothing can be printed to view. I tried to implement a way to verify the `string`, but check if it is `null` is not enough.
