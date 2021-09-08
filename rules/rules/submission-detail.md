# Submission Detail

In the **Evaluation Stage**, each submission will be tested by the evaluation queue and every contestant should submit their results following the format below.

> Please follow the structure listed on the submission detail to ensure your score.

## ℹ Submission Format

The contestants' goal is to submit a **Python code file/zip** and a **MindSpore checkpoint file** where it will be run on Ascend 910 for inference on a dataset. The Python code has some requirements that need to be accomplished.

1. Python code \(**participant\_model.py**\) will need to describe the model structure, preprocessing and postprocessing, and the saliency map.
2. A Checkpoint \(**.ckpt**\) file will [save model parameters](https://www.mindspore.cn/tutorial/training/en/r1.2/use/save_model.html) for inference and retraining after interruption.

## 📇 Python Code Details

An **entry point file** needs to export specific functionalities for the evaluation system.

<table>
  <thead>
    <tr>
      <th style="text-align:left"><b>Variable/Class Name in Python</b>
      </th>
      <th style="text-align:left"><b>Description</b>
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left">
        <p><code>class</code>  <b><code>Net</code></b><code>(</code>
        </p>
        <p><code>mindspore.nn.Cell</code>
        </p>
        <p><code>)</code>
        </p>
      </td>
      <td style="text-align:left">
        <p>This class extends <b><code>mindspore.nn.Cell</code></b> which is the standard
          way to instantiate a network in MindSpore.</p>
        <p>Participants can name their class anything as long as the evaluation system
          is able to read the variable <b>Net</b> from the file.</p>
        <p>Therefore a way to rename an existing class to <b>Net</b> can be easily
          done as below.</p>
        <p><code>Net = FasterRCNN</code>
        </p>
        <p>Assuming <b>FasterRCNN</b> was used as the class name for the network.</p>
        <p>The model checkpoint uploaded, will then be loaded into the network.</p>
        <p><em>(Optionally, the participant can use a callable as long as the callable returns a</em>  <em><b><code>mindspore.nn.Cell</code></b>instance)</em>
        </p>
      </td>
    </tr>
    <tr>
      <td style="text-align:left">
        <p><em>(Optional)</em>
        </p>
        <p><code>def</code>  <b><code>pre_process</code></b>  <code>(</code>
        </p>
        <p> <code>image_id,</code>
        </p>
        <p> <code>image</code>
        </p>
        <p><code>)</code>
        </p>
      </td>
      <td style="text-align:left">
        <p>This function allows participants to <b>preprocess the dataset</b> so that
          the network can receive the correct data format.</p>
        <p>The <b><code>image_id</code></b> is the string for identifying an instance
          of the image.</p>
        <p>The <b><code>image</code></b> is the CHW numpy 3 dimensional array.</p>
        <p>Each test image will be called onto this function, and participants can
          use the <b><code>image_id</code></b> to locate the variables that might be
          needed in the <b><code>post_process</code></b> function.</p>
        <p>The return value will be sent into the model as simple as:</p>
        <p><b><code>net = Net()</code></b>
        </p>
        <p><b><code>predictions = net(</code></b>
        </p>
        <p> <b><code>pre_process(image_id, image)</code></b>
        </p>
        <p><b><code>)</code></b>
        </p>
        <p>Additionally, if you are <b>returning a Python dictionary,</b> we will split
          the key-value pairs into the model with the <b>spread operator(<code>**</code>)</b>.
          Below shows an example of the action:</p>
        <p><code>net = Net()</code>
        </p>
        <p><code>predictions = net(</code>
        </p>
        <p> <b><code>**pre_process</code></b><code>(image_id, image)</code>
        </p>
        <p><code>)</code>
        </p>
        <p>In this case, the parameter name in the <b><code>construct</code></b> function
          of <b><code>Net</code></b> is important if you have multiple parameters.</p>
        <p><em>(The output of the function should not be a NumPy array or dictionary with any values of NumPy array, as MindSpore internal engine rejects any value of NumPy array. A simple solution would be to apply the function</em>  <em><b><code>mindspore.Tensor</code></b></em>  <em>on the output values)</em>
        </p>
        <p>&lt;em&gt;&lt;/em&gt;</p>
        <p><em>If there is no</em>  <b><code>pre_process</code></b>  <em>function the image will instead be converted into Tensor and sent into the network.</em>
        </p>
      </td>
    </tr>
    <tr>
      <td style="text-align:left">
        <p><em>(Optional)</em>
        </p>
        <p><code>def</code>  <b><code>post_process</code></b><code>(</code>
        </p>
        <p> <code>image_id,</code>
        </p>
        <p> <code>prediction</code>
        </p>
        <p><code>)</code>
        </p>
      </td>
      <td style="text-align:left">
        <p>This function allows participants to parse the output from the model,
          the final output format of the data is a 2D-Array, with the number of bounding
          boxes as the first dimension and bounding boxes details as the second dimension.
          <br
          />
        </p>
        <p>The <b>image_id</b> is the string for identifying an instance of the image.
          <br
          />
        </p>
        <p>The <b>prediction</b> is the output from the model, the return type is the
          same as the return type of the <b>construct</b> function in the <b>Net</b>.
          <br
          />
        </p>
        <p>The return value of each row in the array should be:</p>
        <p> <b><code>[xmin,ymin,xmax,ymax, p0,p1,p2,p3]</code><br /></b>
        </p>
        <p>Where p0 to p3 are the probabilities for <b><code>scc</code></b>, <b><code>ac</code></b>,<b><code>sclc</code></b>,
          and<b><code>nsclc</code></b> respectively. The coordinates and the probabilities
          should be in the <b>range of [0, 1]</b>.
          <br />
        </p>
        <p>As an example the bounding box of the <em>top half of the image</em> with
          the label <em>SCC</em> and <em>NSCLC</em> would be:</p>
        <p><code>[</code>
        </p>
        <p> <code>[0, 0, 1, 0.5, 1, 0, 0, 1],</code>
        </p>
        <p> <code>... # some other bounding boxes</code>
        </p>
        <p><code>] # 2d array</code>
        </p>
        <p>&lt;code&gt;&lt;/code&gt;</p>
        <p>If there is no <b><code>post_process</code></b> function then the evaluation
          system expects your return value to be correctly specified.</p>
      </td>
    </tr>
    <tr>
      <td style="text-align:left">
        <p><em>(Optional)</em>
        </p>
        <p><code>def</code>  <b><code>saliency_map</code></b><code>(</code>
        </p>
        <p> <code>net,</code>
        </p>
        <p> <code>image_id,</code>
        </p>
        <p> <code>image,</code>
        </p>
        <p> <code>predictions</code>
        </p>
        <p><code>)</code>
        </p>
      </td>
      <td style="text-align:left">
        <p>This function allows you to output a saliency map from the model with
          the image. You should utilize the <a href="https://www.mindspore.cn/doc/api_python/zh-CN/r1.2/mindspore/mindspore.explainer.html"><b><code>mindspore.explainer</code></b></a>toolkit
          to complete this task.
          <br />
        </p>
        <p>The <b><code>net</code></b> is the instance of the <b><code>Net</code></b> with
          the checkpoint loaded.
          <br />
        </p>
        <p>The <b><code>image_id</code></b> is the string for identifying an instance
          of the image.
          <br />
        </p>
        <p>The <b><code>image</code></b> is the CHW NumPy 3 dimensional array.
          <br />
        </p>
        <p>The <b><code>prediction</code></b> is the output from the model, the return
          type is the same as the return type of the <b><code>construct</code></b> function
          in the <b><code>Net</code></b>.
          <br />
        </p>
        <p>The return type should be a 2d-NumPy array with the shape of <b>(H, W)</b> where <b>H</b> and <b>W</b> are
          the height and the width of the <b>image</b> respectively. The values in
          the matrix should be in the <b>range of [0, 1].</b> You can obtain the saliency
          map as easy as:</p>
        <p><code>from mindspore.explainer.explanation \</code>
        </p>
        <p> <code>import Occlusion</code>
        </p>
        <p><code>deconv = Occlusion(net)result = deconv(image)</code>
        </p>
        <p>
          <br />If there is no <b><code>saliency_map</code></b> the function then the evaluation
          system assumes that you opt-out for the <em><b>Special Prize for Explainability</b></em> and
          will not score for the <b>Explainable Task</b>.</p>
      </td>
    </tr>
  </tbody>
</table>

> `CHW` implies \(C\)Channel first, then the \(H\)Height dimension, and finally the \(W\)Width dimension. Eg. of an image shape would be \(3, 720, 1280\) for a 720p RGB image
>
> Some of the libraries might not be supported by **ModelArts** \(evaluation system\), participants are required to find alternatives or email an **inquiry to** [**support@mindsporechallenge.com**](mailto://support@mindsporechallenge.com) **/** [**Discord**](https://discord.com/invite/SDpVGMxpWe), and participants can use the ModelArts account provided for training models to test the submitted code, the environment for the evaluation system is supposed to be the same.

The sample submission code file is as below:

```python
import numpy as np
import mindspore as ms

class Net(ms.nn.Cell):
    def __init__(self):
        super(Net, self).__init__()

    def construct(self, x):

def pre_process(image_id: str, image: np.array):
  """
  Keyword arguments:
  image_id -- str format, for identifying an image.
  image -- np.array of CHW format.

  Returns:
  pre_processed_data -- dict or ms.Tensor, to be passed into the input.
  """

def post_process(image_id: str, prediction: ms.Tensor):
    """
    Keyword arguments:
    image_id -- str format, for identifying an image.
    prediction -- the output of the network.

    Returns:
    results -- np.array or 2d-list,
    [xmin, ymin, xmax, ymax, p0, p1, p2, p3][]
    p0 to p3 implies probabilities for SCC, AC, SCLC, NSCLC
    """

def saliency_map(
    net: Net,
    image_id: str,
    image: np.array,
    prediction: ms.Tensor
):
    """
    Keyword arguments:
    net -- ms.nn.Cell format, an instance of the Net class.
    image_id -- str format, for identifying an image.
    image -- np.array of CHW format.
    prediction -- the output of the network.

    Returns:
    result -- np.array, with the same shape of the image width and height, but only one channel. Shape: (H, W)
    Should be the result from ms.explainer.*
    """
```

Participants can use this template to complete the code submission on the website:

> [https://mindsporechallenge.com/submission](https://mindsporechallenge.com/submission/index)

## 🆙 Submit Code to MSC21 Platform

### Accepted Format

* **A single Python file; or**
* **All codes in a zip/tarball**

> Supported formats of zip/tarball, _.tar.bz2, .tbz2, .tar.gz, .tgz, .tar, .tar.xz, .txz, .zip_

If a zip/tarball file is submitted instead, We will unzip the file and find the entry point Python code. We will traverse the folder to find the **participant\_model.py** file, this file is the entry point of the code. We expect this file to be in the _root or any first-level directory_. If there are multiple files of the same name, we might have problems finding the one that we needed, it’s the participant's responsibility to keep this from not happening.

### Evaluation Code

The following code will be carried out with your submission on the evaluation system:

```python
import numpy as np
import mindspore as ms
import participant_model

net = participant_model.Net()

param_dict = ms.load_checkpoint(model_checkpoint_file)
ms.load_param_into_net(net, param_dict)

results = []
xai_results = []
for image_id, image in data:
   if hasattr(participant_model, 'pre_process'):
       pre_processed_data = participant_model.pre_process(
           image_id, image
       )
   else:
       pre_processed_data = ms.Tensor(image)

   if type(pre_processed_data) == dict:
      prediction = net(**pre_processed_data)
   else:
      prediction = net(pre_processed_data)

   if hasattr(participant_model, 'pre_process'):
       result = participant_model.post_process(
           image_id, prediction
       )
   else:
       result = prediction

   if hasattr(participant_model, 'saliency_map'):
       xai_result = participant_model.saliency_map(
           net, image_id, image, prediction
       )
   else:
       xai_result = None

   results.append(result)
   xai_esults.append(xai_result)
```

The above code will be run in the ModelArts Atlas 910 for faster inference. But due to the limitation of this competition, the participants are required to reduce the complexity of the model. Any model tested for more than **120 minutes** will be terminated, and the scoring will not be considered. The participants can only submit **30 times throughout the competition**.

## 🏅 Ranking

After submission, participants can view their ranking in the following URL:

> [https://mindsporechallenge.com/history](https://mindsporechallenge.com/history)

Teams will submit their solution for each round through the Competition Portal. _Only one submission can be run at any time_ and teams may submit more than one submission as long as they do not interfere with the proper functioning of the competition. Only the highest-scoring submission will be considered.

## 🏁 Final Pitching Submission

If participants successfully entered the Final Pitching, participants are required to **email** the following documents to the `support@mindsporechallenge.com` before **20 October 2021, 23:59:59 \(UTC +8\)** :

1. Codebases, containing Jupyter Notebook explaining the model design methodology
2. Presentations

> **Late submission will not be entertained**, and participants will be considered opting out of the competition.

All submissions must be derived from participants' work, and any use of code from other parties that are not of team members required a citation. The authority should also be added to the presentation for the final round.

## Other terms

Contestants retain sole ownership of their original work. The submission remains the intellectual property of the contestant, and the organizers make no claim of copyright as to the work of any individual who enters the contest. All the submitted materials are sole to be used within this competition.

The contestant specifically agrees to give the organizers permission to use all content submitted for purposes of judging the contest. Finalists and/or winners will be required to grant the organizers, with proper attribution through whatever means they deem appropriate, a worldwide, non-exclusive, royalty-free, sub-licensable and transferable license to use, reproduce, distribute, prepare derivative works of, and/or display the submission in any media formats and through any media channels in perpetuity in connection with the activities and operations of the contest. Each finalist and/or winner represents and warrants that he or she has the unrestricted right to grant such license.

As a condition of entering the Final Pitching and/or receipt of the prize, finalists and/or winners must deliver to the organizers the final model’s software code as used to generate the winning Submission and associated documentation. The delivered software code must be capable of generating the winning Submission and contain a description of resources required to build and/or run the executable code successfully.

