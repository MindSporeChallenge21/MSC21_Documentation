# Appendix

### Recall-False Positive/Image calculation for samples

For every class, we select ground truth bounding boxes\(T\) for the class, and the prediction bounding boxes\(P\) for the class.

The **FROC** value can be calculated with the following algorithm:

* For each threshold
  * For each bounding boxes pairs, \(prediction, P\) \(ground truth, T\):
    * If P’s probability &lt; threshold:
      * Ignore pair.
    * Find the maximum IoP for P in all the pairs \(P, \*\)
    * If the maximum IoP &gt; 0.5:
      * This prediction bounding-box is considered as correctly predicted \(predicting the ground truth bounding box\), i.e. TP += 1
      * Subsequent bounding-box on this ground truth will not be considered, i.e. TP and FP does not change
  * FP = number of prediction bounding-box that does not match any IoP &gt; 0.5
  * Recall: TP / number of ground truth bounding-box
  * False Positive/ image: FP / number of images
* Plot values for each threshold on a Recall-False Positive/Image graph, interpolate values with linear interpolation.
* Using the 6 values of False Positive/Image to find the Recall values and average them to get FROC.

_\* TP = True Positive; FP = False Positive_

