import os
import asyncio

def query_directory(app_path, depth=3):
  paths = []
  for root, dirs, files in os.walk(app_path):
    level = root.replace(app_path, '').count(os.sep)
    if level == depth:
      paths.append(root)
  return paths

async def show_path(app_path):
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

  loop = asyncio.get_event_loop()

  tasks = []
  for app_path in app_paths:
    tasks.append(
      loop.create_task(show_path(app_path))
    )

  loop.run_until_complete(asyncio.wait(tasks))
  loop.close()


