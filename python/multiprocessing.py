import os
import time
import multiprocessing

def query_directory(app_path, depth=3):
  paths = []
  for root, dirs, files in os.walk(app_path):
    level = root.replace(app_path, '').count(os.sep)
    if level == depth:
      paths.append(root)
  return paths

def show_path(app_path):
  time.sleep(10)
  print(f"multiprocess path = {app_path}")


if __name__ == "__main__":
  root = "/Users/bill.lien.-nd"
  app_path_roots = [
    f"{root}/work",
    f"{root}/ddsi"
  ]

  app_paths = []
  for app_path_root in app_path_roots:
    paths = query_directory(app_path_root, 1) 
    app_paths.extend(paths)

  processes = []
  for app_path in app_paths:
    print(f"path = {app_path}")
    process = multiprocessing.Process(target=show_path, args=(app_path,))
    processes.append(process)

  print("Start all processes...")
  for process in processes:
    process.start()

  print("Make sure that all processes have finished...")
  for process in processes:
    process.join(timeout=5)

  for process in processes:
    if process.is_alive():
      print("Process timed out. Terminating...")
      process.terminate()

