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

There are few versions of datasets. The primary dataset for user training and validation is **`dataset_1`**. This dataset contains 500 images.

| **Dataset Name** | **Publicly Accessible** | **Description** |
| :--- | :--- | :--- |
| `dataset_1` | Yes | 500 data points for experimentation and model design. |
| `dataset_2` | Restricted Access | User access through Huawei Cloud’s OBS, in ModelArts. |
| `dataset_3` | No | For Accuracy task, and Explainable task \(with masks\). |

## 1 Dataset 1

{% hint style="info" %}
The data\(dataset\_1\) can be obtained through the OBS bucket from Huawei Cloud of the following URL.

[https:////](https://google.com)
{% endhint %}

In the **dataset\_1** there are 500 images and a CSV label file, and after unzipping the data you will receive the file structure as below:

* images
  * sample\_0001.bmp
  * sample\_0002.bmp
  * …
  * sample\_0500.bmp
* labels.csv

The labels contain few columns namely:

> **`image_id, xmin, ymin, xmax, ymax, scc, ac, sclc, nsclc`**

The labels \(**`xmin`**, **`ymin`**, **`xmax`**, **`ymax`**\) will be floating-point numbers between 0 and 1. For the x-axis, the related columns are `xmin` and `xmax`, the value 0 corresponds to the left side of the image, and 1 corresponds to the right side of the image. For the y-axis, the same idea applies, but with 0 value at the top of the image and 1 at the bottom corner of the image.

The classes \(**`scc`**, **`ac`**, **`sclc`**, **`nsclc`**\) is the classification of the cancer cells, because there are multiple classes per cell \(multi-label classification problem\), each class has a column with value 1 if the bounding boxes belong to the class. With the **`image_id`** the image filename can be obtained by concatenating the **`image_id`** with the **`.bmp`** file extension.

Contestants are expected to design a model for finding the bounding boxes for the samples and classify the diagnosed cells.

## 🔏 Data Privacy

{% hint style="danger" %}
1. The data published by LBP Medicine does not contain patients’ information.
2. The Huawei Research Center does not own the copyright of the images and the labels.
3. The use of the photos must abide by the Term of service of LBP Medicine.
4. The users of the photos accept full responsibility for the use of the dataset, including but not limited to the use of any copies of copyrighted images that they may create from the dataset.
{% endhint %}

By participating in this competition, users are allowed to access this dataset. There is some limitation in the use of this dataset. **The users may only use this dataset within the competition**. Within this competition, the definition of any code or software that accesses this dataset or reads this dataset in any manner must be part of the research or experimentation related to producing a model for this competition. The use of this dataset in the commercial context is prohibited.

Commercial purposes include, but are not limited to:

1. Training or proving the efficiency of commercial systems,
2. Using screenshots of subjects from the dataset in advertisements,
3. Selling a subset of data or the preprocessed forms of data from the dataset.
4. Creating military applications.

Any model or software derived from this dataset, through training autonomously or by data, the inspection must be approved by Huawei Hong Kong Research Center and LBP Medicine.

The Huawei Hong Kong Research Center and LBP Medicine reserve the right to modify and change this dataset and the section Dataset Privacy in this Rule Book and Guidelines for MindSpore Pathology Diagnosis Challenge. This dataset comes without any warranty, and Huawei Research Center and LBP Medicine cannot be held accountable for any damage \(physical, financial, or otherwise\) caused by the use of this dataset.

