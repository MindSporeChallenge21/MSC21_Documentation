# 📥 MindSpore Installation Guide

## Installation Flow:

* [x] Installing GCC
* [x] Installing Python
* [x] Installing JupyterLab/JupyterNotebook
* [x] Installing MindSpore
* [x] Verify Installation

> 1st part installation follows [https://bbs.huaweicloud.com/forum/thread-108694-1-1.html](https://bbs.huaweicloud.com/forum/thread-108694-1-1.html)   
> 2nd part of the installation follows [https://mindspore.cn/install](https://mindspore.cn/install)   
> \* version of this documentation is Ubuntu Desktop 18.04

### Installing prerequisite

```bash
sudo apt-get update &&
sudo apt-get install -y build-essential m4 libgmp-dev libmpfr-dev libmpc-dev zlib1g-dev libffi-dev make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl openssl
```

## Installing GCC \(GNU Compiler Collection\)

### GCC version check _\(Required 7.3.0 Ver\)_

```bash
gcc --version
```

\* using `sudo apt install gcc` works, but the version is `7.5.0` we need version `7.3.0` version of gcc.

```bash
# Grab the package from internet
wget "http://ftp.gnu.org/gnu/gcc/gcc-7.3.0/gcc-7.3.0.tar.gz"
# Extract the tarball
tar -xzf gcc-7.3.0.tar.gz 
# Go into the extracted folder
cd gcc-7.3.0
# Configuring the gcc installation
 ./configure --enable-checking=release --enable-languages=c,c++ --disable-multilib
```

```bash
make -j 12 && sudo make install -j 12
```

{% hint style="info" %}
Make, \(`-j` to run multiple make target at once because this process takes time!\)
{% endhint %}

After make the GCC should be installed properly. Now we want to replace the GCC on the current machine with a new one\(7.3.0\) by using a soft link.

```bash
sudo ln -sf /usr/local/gcc/bin/gcc /usr/bin/gcc
```

To confirm the installation is complete

```bash
gcc --version
```

The output should be

```text
gcc (GCC) 7.3.0
Copyright ....
```

## Installing Python _\(Version 3.7.5\)_

Visit Python official website [https://www.python.org/downloads/release/python-375/](https://www.python.org/downloads/release/python-375/) Scroll down to download the `Gzipped source tarball` version. Or

```bash
wget "https://www.python.org/ftp/python/3.7.5/Python-3.7.5.tgz"
# Unzip 
tar -xzf Python-3.7.5.tgz
cd Python-3.7.5
`
```

From the `README.rst` we can see that there is command for installation

```bash
./configure --with-ssl && 
make &&
sudo make install
```

{% hint style="danger" %}
if you failed at `zlib not available problem` please run `sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl openssl`
{% endhint %}

{% hint style="danger" %}
if `pip3` failed at installing things due to SSL problems please run `./configure --with-ssl && make && sudo make install`
{% endhint %}

Test your installation

```bash
python3 --version
```

Output should looks like

```text
Python 3.7.5
```

## Install Jupyter Lab

```bash
pip3 install jupyterlab
```

\* if pip failed due to SSL problem please check References 1   
\* if pip failed due to permissions use `--user` flag \(Futher problem on installation need to check if jupyter is added into `$PATH`\) or run the command as sudo. \(ie. `sudo pip3 install jupyterlab`\) 

Test the installation with

```bash
cd ~
jupyter lab
```

## Installing MindSpore

You can obtain the command of installing MindSpore from [https://mindspore.cn/install](https://mindspore.cn/install) Just be aware of the pip command, for `python3` use `pip3` for installation instead of `pip`. As an example a Ubuntu x86 chipset.

```bash
pip3 install https://ms-release.obs.cn-north-4.myhuaweicloud.com/1.2.0/MindSpore/cpu/ubuntu_x86/mindspore-1.2.1-cp37-cp37m-linux_x86_64.whl --trusted-host ms-release.obs.cn-north-4.myhuaweicloud.com
```

\* if its related to permission errors, use add `--user` flag to install into current user dir

### Verfiy Installation

You can verify installation by running the command of `python3 -c "import mindspore;print(mindspore.__version__)"` The result should be 1.2.1

\* if you face error of `libcce.so` consider reinstalling with `pip3` without using the `sudo` command for MindSpore

### References:

1. [https://blog.csdn.net/jeryjeryjery/article/details/77880227](https://blog.csdn.net/jeryjeryjery/article/details/77880227) - `pip3` SSL cannot import
2. [https://www.cnblogs.com/jimc/p/10218062.html](https://www.cnblogs.com/jimc/p/10218062.html) - `zlib` not available at `sudo make install` step of Python.
3. [https://bbs.huaweicloud.com/forum/thread-58213-1-1.html](https://bbs.huaweicloud.com/forum/thread-58213-1-1.html) - missing `libcce.so`

