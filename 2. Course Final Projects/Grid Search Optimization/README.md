# Advanced Optimization - Grid Search Optimization <a name="gridsearch"></a>

<p align="center">
  <img src="https://user-images.githubusercontent.com/20640612/144015610-e3f73bc8-ba73-424a-ac8d-2a96926bfa89.gif" alt="Grid Search" width="400"/>
</p>

- **Duration:** 2 weeks.
- **Group Size:** 3.
- **Project Description:** An open project on optimization topics. We were asked to contribute to any existing open-source project with an application in optimization algorithms. We worked on an open issue of the Gradient Free Optimizers library ([Gradient-Free-Optimizers](https://github.com/SimonBlanke/Gradient-Free-Optimizers)) of Python aiming to **implement Grid Search optimization**. Grid Search is a brute force optimization algorithm which computes the target function over a specified grid and returns the minimizing/maximizing index.
- **Final Result:** As part of an existing open-source project, we adopted the Object Oriented Approach to inherit pre-existing Parent classes. The brute implementation of Grid Search is quite simple: start at the top left of the grid and make a jump on the right at each step. We observed a major inconvenience with this method. In most cases, Grid Search is run on a finite number of steps rather than on the grid's total size. Therefore, we designed a method that would explore a larger and sparser area of the grid in a low number of steps. This method is based on the cyclic nature of **mZ** in **Z/pZ** when **p** and **m** are prime. Thus, by choosing a convenient value of **m**, prime to the total grid size **p**, and searching through the grid in a **mZ** manner, we observe sparser areas of the grid in a low amount of iterations. The cyclic nature of our search method ensures that the grid is completely covered in **p** iterations, which ensures equal time complexity to the normal method.
- **Grade:** 19/20.

---

- **Files Description:**
    - ****

<br>

<p align="center">
  <b>Persistence Diagram Properties Before Major Market Crashes</b>
  <img src="./images/persistencediagrams.png" alt="persistence" width="600"/>
</p>
