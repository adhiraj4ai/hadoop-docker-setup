# HDFS Commands

## 1. List Files (-ls)

Used to list files and directories in HDFS.

```bash
# List root directory
hdfs dfs -ls /
```

```bash
# List a specific directory
hdfs dfs -ls /user
```
## 2. Create Directory (-mkdir)
Used to create directories in HDFS.
```bash
# Create a directory
hdfs dfs -mkdir /user
```

```bash
# Create nested directories
hdfs dfs -mkdir -p /user/yourname/data
```
## 3. Upload Files (-put)
Used to upload files from the local filesystem to HDFS.
```bash
# Create a local test file
echo "Hello HDFS" > test.txt
```

```bash
# Upload to HDFS
hdfs dfs -put test.txt /user/
```

```bash
# Verify
hdfs dfs -ls /user
```

## 4. Download Files (-get)
Used to download files from HDFS to the local filesystem.
```bash
# Download from HDFS to local
hdfs dfs -get /user/test.txt ./downloaded.txt
```

```bash
# Check local file
cat downloaded.txt
```

## 5. View File Content (-cat)
Used to view the contents of a file stored in HDFS.

```bash
hdfs dfs -cat /user/test.txt
```

## 6.  Files (-cp)
Used to copy files within HDFS.
```bash
#  within HDFS
hdfs dfs -cp /user/test.txt /user/backup.txt
```
Let's verify the copied file now.
```bash
# Verify
hdfs dfs -ls /user
```

## 7. Move/Rename Files (-mv)
Used to move or rename files within HDFS.

```bash
# Rename/move
hdfs dfs -mv /user/backup.txt /user/renamed.txt
```
Verify the moved file
```bash
# Verify
hdfs dfs -ls /user
```
## 8. Delete Files (-rm)
Used to delete files and directories in HDFS.
```bash
# Delete a file
hdfs dfs -rm /user/renamed.txt
```

```bash
# Delete directory (recursively)
hdfs dfs -rm -r /user/old_data
```

## 9. Check Disk Usage (-du)
Used to get the size of files and directories in HDFS.

```bash
#Check size of files in a directory
hdfs dfs -du /user

#Check for human readable size
hdfs dfs -du -h /user
```

## 10. Show File Statistics (-stat)
Used to display stats like size, modification date, etc.

```bash
# Show file statistics
hdfs dfs -stat /user/test.txt
```

## 11. Display File Checksums (-checksum)
Used to get checksum information of a file.

```bash
hdfs dfs -checksum /user/test.txt
```

## 12. Change Permissions (-chmod)
Used to change file or directory permissions in HDFS.

```bash
hdfs dfs -chmod 755 /user/test.txt
```

## 13. Change Ownership (-chown)
Used to change the owner and group of a file/directory.

```bash
hdfs dfs -chown user1:hadoop /user/test.txt
```