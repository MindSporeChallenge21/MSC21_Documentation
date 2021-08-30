# Data

## 👁🗨 Overview

There are two formats of the data, which are the images and bounding boxes data. The data format is as follows, each biopsy sample will be an image. Contestants will be given a set of pictures with the name **sample\_0001.bmp**

## 🏷 Labels

The labels of the data are the bounding boxes \(**`xmin`**, **`ymin`**, **`xmax`**, **`ymax`**\). There could be more than one bounding box for each sample. For each bounding box, there will be a few associated classifications for the identified cells.

The classification is as follow:

| **Class** | **SCC** | **AC** | **SCLC** | **NSCLC** |
| :--- | :--- | :--- | :--- | :--- |
| English Name | Squamous Cell Carcinoma | Adenocarcinoma | Small Cell Lung Cancer | Non-Small Cell Lung Cancer |
| Index | 0 | 1 | 2 | 3 |
| Sub-class | NSCLC | NSCLC |  |  |
| Example Sample | ![](../../.gitbook/assets/0%20%281%29.png) | ![](../../.gitbook/assets/1.png) | ![](../../.gitbook/assets/2%20%281%29.png) | ![](../../.gitbook/assets/3%20%281%29.png) |
| Count in dataset\_1 |  |  |  |  |

## 🏬 Datasets

There are a few subsets of datasets. The primary dataset for user training and validation is **`dataset_1`**. This dataset contains 500 images.

| **Dataset Name** | **Publicly Accessible** | **Description** |
| :--- | :--- | :--- |
| `dataset_1` | Yes | 500 data points for experimentation and model design. |
| `dataset_2` | Restricted Access | User access through Huawei Cloud’s [OBS](https://www.huaweicloud.com/en-us/product/obs.html), in [ModelArts](https://www.huaweicloud.com/intl/en-us/product/modelarts.html). |
| `dataset_3` | No | For Accuracy task, and Explainable task \(with masks\). |

## 1 Dataset Description  - `dataset_1`

> The data \(**`dataset_1`**\) can be obtained through the OBS bucket from Huawei Cloud of the following URL.

[https:////](https://google.com)

In the **dataset\_1** there are 500 images, a CSV label file, and a metadata CSV file in zipped format. The file structure for the datasets \(**`dataset_1`**\) are as below:

* images
  * sample\_0001.bmp
  * sample\_0002.bmp
  * …
  * sample\_0500.bmp
* labels.csv
* metadata.csv

A further description of the labels is in the [Dataset Description Section](data.md#dataset-description).

## 2 Dataset Description  - `dataset_2`

> The data \(**`dataset_2`**\) can be obtained through ModelArts Moxing Framework only. From Huawei Cloud's OBS Bucket

images: obs:////

labels: obs:////

In the **dataset\_2** there are 4000 images, a CSV label file, and a metadata CSV file. A further description of the labels is in the [Dataset Description Section](data.md#dataset-description). Since you can only access the dataset through **Moxing Framework** in **ModelArts**, we highly encourage participants to use the ModelArts for Training, because it is faster and more efficient for experimentation.

### [ModelArts Moxing Framework](https://support.huaweicloud.com/intl/en-us/moxing-devg-modelarts/modelarts\_11\_0003.html)

> Further information for ModelArts and Moxing is in the training and testing guidelines

## 3 Dataset Description  - `dataset_3`

The **`dataset_3`** is specifically for evaluation purposes. Each image will be passed into the user-defined functions for evaluation purposes.

This dataset also contains a set of masks for selected datasets, these mask contains information regarding the important parts for recognizing the labels. These masks will be compared against the saliency map produced in your code.

## 🔢 Dataset Description

The images are in `.bmp` format, which can be easily read by common python packages.

The **`labels.csv`** contain few columns namely:

> **`image_id, xmin, ymin, xmax, ymax, scc, ac, sclc, nsclc`**

The labels \(**`xmin`**, **`ymin`**, **`xmax`**, **`ymax`**\) will be floating-point numbers between 0 and 1. For the x-axis, the related columns are `xmin` and `xmax`, the value 0 corresponds to the left side of the image, and 1 corresponds to the right side of the image. For the y-axis, the same idea applies, but with 0 value at the top of the image and 1 at the bottom corner of the image.

The classes \(**`scc`**, **`ac`**, **`sclc`**, **`nsclc`**\) is the classification of the cancer cells because there are multiple classes per cell \(multi-label classification problem\), each class has a column with value 1 if the bounding boxes belong to the class. With the **`image_id`** the image filename can be obtained by concatenating the **`image_id`** with the **`.bmp`** file extension.

To facilitate some action in reading the dataset, we prepared the **`metadata.csv`** file, this file contains the metadata of the images with the columns namely:

> **`image_id, width, height, bbox_count`**

This file is created to support participants in working with the dataset.

Be reminded that there are healthy samples in this dataset, which means images without any bounding boxes, this images will not have any column in the `labels.csv`, because they are healthy cells.

Contestants are expected to design a model for finding the bounding boxes for the samples and classify the diagnosed cells.

## 🔏 Dataset Terms and Conditions

> 1. The data published by **LBP Medicine** does not contain patients’ information.
> 2. The ownership and the copyright of the images and the labels belong to **LBP Medicine**.
> 3. The use of the photos must abide by the Term of service of **LBP Medicine**.
> 4. **LBP Medicine** guarantees that the data required in this competition are obtained through legal channels.

By participating in this competition, contestants are allowed to access this dataset. There is some limitation in the use of this dataset. **The users may only use this dataset within the competition**. Within this competition, the definition of any code or software that accesses this dataset or reads this dataset in any manner must be part of the research or experimentation related to producing a model for this competition. The use of this dataset in the commercial context is **prohibited**.

> The contestants accept full responsibility for the use of the dataset, including but not limited to the use of any copies of images that they may create from the dataset.

Commercial purposes include, but are not limited to:

1. Training or proving the efficiency of commercial systems,
2. Using screenshots of subjects from the dataset in advertisements,
3. Selling a subset of data or the preprocessed forms of data from the dataset.
4. Creating military applications.

The **LBP Medicine** reserves the right to modify and change this dataset and the section Data Terms and Conditions in this Rule Book and Guidelines for MindSpore Pathology Diagnosis Challenge. This dataset comes without any warranty, and LBP Medicine cannot be held accountable for any damage \(physical, financial, or otherwise\) caused by the use of this dataset.

