# Topological Methods for Data Analysis - Analyzing Financial Time Series with Persistent Homology <a name="financecrash"></a>

<p align="center">
  <img src="../../images/dotcomcrash.jpeg" alt="Dotcom Crash" width="400"/>
</p>

- **Duration:** 2 weeks.
- **Group Size:** 2.
- **Project Description:** The goal of this project was to **analyze the evolution of daily returns of four major US stock market indices** over the period 1989-2016 using persistent homology. This project was an extension of [Topological Data Analysis of Financial Time Series: Landscapes of Crashes](https://arxiv.org/pdf/1703.04385.pdf) whose focus was to prove TDA (Topological Data Analysis) would bring **new analysis methods for early market crash detection**. We aimed to reproduce their analysis with our own implementation of persistence landscapes (compare to Gudhi library of Python) and further improve their results. 
- **Final Result:** First, we implemented an Object Oriented version of Persistence Landscapes (representation of a topological dataset's Rips Filtration in a Banach Space, see [1](https://arxiv.org/pdf/1703.04385.pdf) for further details).  We compared our implementation to the existing Gudhi library, which is state-of-the-art, and proved our implementation is better by a margin in terms of both correctness and time complexity. Second, we developped the paper's analysis by reimplementing their method and adding additional arguments to support their claim. As they mention, TDA seems to be an efficient method to detect market crashes early. Indeed, the latter show brutal intakes in variance and spectral density of the $L^1$ and $L^2$ norms of their persistence landscapes prior to both the Dotcom Crash and the Lehmann Bankruptcy. Moreover, **we have shown that using variable window sizes and higher order norms for the topological analysis enable earlier detection of major stock market crashes**. Though a compromise must be found between precision and computational constraints, the choice of a higher window size and higher degree norms is advised.
- **Grade:** 15/20.

---

- **Files Description:**
    - **[Project Code -](https://github.com/EdouardVilain-Git/EdouardVilain-M2-DSBA/blob/main/2.%20Course%20Final%20Projects/Analyzing%20Financial%20Time%20Series%20with%20Persistent%20Homology/Project%20Code.ipynb)** Notebook containing all the research pipeline.
    - **[Final Report -](https://github.com/EdouardVilain-Git/EdouardVilain-M2-DSBA/blob/main/2.%20Course%20Final%20Projects/Analyzing%20Financial%20Time%20Series%20with%20Persistent%20Homology/Report.pdf)** Final project report.

<br>

<p align="center">
  <b>Persistence Diagram Properties Before Major Market Crashes</b>
  <img src="./images/persistencediagrams.png" alt="persistence" width="600"/>
</p>
