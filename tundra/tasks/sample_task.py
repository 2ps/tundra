import time
from tundra.celery import app


@app.task(name='tundra.sample')
def sample_task():
    # perform step 1
    print('Performing step 1')
    time.sleep(2)
    print('Performing step 2')
    time.sleep(4)
    print('Performing step 3')
    time.sleep(8)
    print('Performing step 4')
    time.sleep(16)
    print('Performing step 5')
    time.sleep(16)

