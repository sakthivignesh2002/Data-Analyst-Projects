# Used_Cars Data Analysis 
# Aim
This dataset is a comprehensive tool for understanding and analyzing the dynamic used car market from various angles.


## About Dataset:
- Dataset includes 2000+ used cars with details such as make, model, manufacturer, price, production year, fuel type, selling states, and kilometers driven.
- Provides insights into the used car market, including popular models, manufacturers, and average prices in different states or regions.
- Year of production and kilometers driven offer additional information on vehicle age and condition.
- Fuel type data can help identify regional consumer preferences.

<br>

## <img src="https://user-images.githubusercontent.com/122404051/235767211-297f9f4f-d41a-46ec-838f-13ea23817702.gif"  width="48" height="48"> Data Preparation:

![excelsheet](https://user-images.githubusercontent.com/128036066/235987911-b62660a6-1485-4fda-af9f-947f280d3d24.png)

To prepare the data, we performed the following steps using the Power Query Editor:
  1. Dropped nulls, blank rows, and duplicate rows.
  2. Created a "Row ID" column as the unique identifier for each row, starting from 1000 with an increment of 1 for each row.
  3. Changed the data types of the columns accordingly.
  4. Created two new columns from the car_name column: "Brand" and "Car model".
  5. Removed the original "car_name" column.

## Data Analysis:
We analyzed the data to gain insights into the used car market, including the following:
  1. Relationship between the age of a used car and its price.
     
     <img src="https://github.com/Venkatesh-Nayk/Dynamic-PowerBI-Dashboard/assets/129421850/528ef831-be55-42f3-9c40-406062a7cbe0" alt="Image Description" height="250" width="500">

  2. Top 10 brands based on the average price.
     
     <img src="https://github.com/Venkatesh-Nayk/Dynamic-PowerBI-Dashboard/assets/129421850/7483690e-1182-46ee-9848-6e304258ddc6" alt="Image Description" height="250" width="500">

  3. Percentage of used cars in different cities for cars whose price is greater than 10 Lakh.
     
     <img src="https://github.com/Venkatesh-Nayk/Dynamic-PowerBI-Dashboard/assets/129421850/126af0f8-f2c1-4c9c-a2ef-bc9be29705f6" alt="Image Description" height="250" width="500">

  4. Number of cars in low, middle, and high-end categories based on price and fuel type.
     
     <img src="https://github.com/Venkatesh-Nayk/Dynamic-PowerBI-Dashboard/assets/129421850/55f607aa-95cd-49b2-8732-24887553b89d" alt="Image Description" height="250" width="500">

 
  <br>

## Dashboard

![image](https://github.com/Venkatesh-Nayk/Dynamic-PowerBI-Dashboard/assets/129421850/e20277fb-8a04-4883-aeca-63401a4e2288)
<br>

## Evaluation Criteria
We evaluated our dashboard based on the following criteria:
  1. Use of interactive filters and slicers to allow users to customize the data being displayed.
  2. Use of clear and concise data labels to provide additional context for data points.
  3. Proper alignment and spacing of visualizations.
  4. Appropriate font size and color scheme.
  5. Clear and concise titles for visualizations, reports, and dashboards.
  6. Use of appropriate background color to improve the visibility of visualizations.

## Conclusion:
- Our analysis of the used car sales dataset revealed several interesting insights that can be valuable for businesses operating in the used car market. Through the use of Power BI, we were     able to transform and visualize the data in a way that allowed us to gain a deeper understanding of the market trends.
- Initially, the dataset consisted of over 2000+ data points. However, following our rigorous data cleaning process, we refined and retained over 900+ high-quality data points for analysis      and insights generation.
- The insights gleaned from our analysis are as follows:
  - The average highest price for a used car typically occurs around the 4-year mark, indicating a significant turning point in pricing trends.
  - In terms of the distribution of used cars among cities, Ahmedabad boasts the highest percentage at 13.56%, closely followed by Hyderabad at 13.35%, suggesting these cities have robust         used car markets.
  - When categorizing the dataset by both price range and fuel type, we found that out of the total 900+ car Data:
    - 762 cars belong to the low-end category, suggesting a preference for more affordable options.
    - 148 cars fall into the middle-end category, reflecting a moderate pricing segment.
    - 36 cars are classified as high-end, indicating a smaller but significant market for premium used vehicles.
- To conclude, our analysis of the used car sales dataset has uncovered key insights related to pricing trends, geographical distribution, and price range segmentation. These findings can       guide businesses in the used car market to make data-driven decisions and enhance their strategies for success.

## Challenges Faced:
 - Used car data had inconsistencies, missing values, and data quality issues, thereby impacting the integrity of the raw dataset.
 - Accurately determining the factors that affect pricing and demand for used cars was complex.
 - Creating meaningful and insightful visualizations for  data was challenging. Choosing the right visualizations effectively to convey information was essential.




