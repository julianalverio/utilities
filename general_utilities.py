import cv2
import os
import copy

def fill_diagonal(arr, value, k):
    height, width = arr.shape
    for row_idx in range(height):
        for col_idx in range(width):
            if (row_idx + k) == col_idx:
                arr[row_idx, col_idx] = value

def make_transmat(size, p=0.99):
    transmat = np.zeros((size, size))
    fill_diagonal(transmat, p, 0)
    fill_diagonal(transmat, 1-p, 1)
    transmat[-1, -1] = 1.
    return transmat


def write_mp4(frames, path, fps=5):
    shape = (500, 500)
    writer = cv2.VideoWriter(path, 0x7634706d, fps, shape)
    for frame in frames:
        writer.write(frame)
    writer.release()


def watch_movie(path):
    cmd = 'open %s' % path
    os.system(cmd)

def get_root():
    root = '/Users/julianalverio/code'
    if not os.path.exists(root):
        root = '/storage/jalverio'
    assert os.path.exists(root)
    return root

def get_path(path, check=True):
    all_root = get_root()
    universal_path = os.path.join(all_root, path)
    original_path = None
    if '.' in path:
        # just get the path to the directory if a file is specified
        original_path = copy.deepcopy(universal_path)
        universal_path = '/'.join(universal_path.split('/')[:-1])

    if not check:
        return universal_path
    if os.path.exists(universal_path):
        return universal_path if not original_path else original_path

    longest_path = copy.deepcopy(universal_path)
    while not os.path.exists(longest_path) and longest_path:
        previous_path = copy.deepcopy(longest_path)
        longest_path = '/'.join(longest_path.split('/')[:-1])
    msg = 'Path error while checking %s \n %s is valid, but %s is not' % (universal_path, longest_path, previous_path)
    raise FileNotFoundError(msg)

