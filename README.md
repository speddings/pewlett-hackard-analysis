# Pewlett Hackard Analysis

## Overview of the Analysis
The purpose of this analysis is to determine the "number of retiring employees by title" and identify employees who are "elibible to participate in a mentorship program", in preparation for the "silver tsunami."  The company has defined eligible retireement age as current employees born between 1952-1955 and hired between 1985-1988.

## Resources
1. PostgresSQL and pgAdmin
2.  Data Source: 6 CSV files provided by Pewlett-Hackard
    1.  departments.csv
    2.  employees.csv
    3.  dept_emp.csv
    4.  dept_manager.csv
    5.  salaries.csv
    6.  titles.csv

## Results of the Analysis
### Entity Relationship Diagrams (ERDs)
- Reviewed the csv's provided by Pewlett-Hackard (Development, Production, and Sales)
- Mapped out Logical Diagram of the db as guide.
  
![diagram](/analysis-project/EmployeeDB.png)

### Employees Eligible for Retirement

- 36,619 employees are eligible for retirement.
- Titles with the highest percentage of staff eligible for retirement. The top three titles are Senior Engineers (35%), Senior Staff (34%), and Engineers (13%)

![table](/analysis-project/retiree-by-title.png)
- The top three departments with the highest percentage of eligible retirees are Development (25%), Production (22%), and Sales (16%)
  
![table](/analysis-project/eligible-by-dept.png)

### Mentorship Candidates

- 1,594 retirees are eligible for the mentorship program, based on a birth date 1952
- 73% of the mentorship retirees are upper level staff (Titles: Senior Staff, Engineer, Senior Engingeer) 
  
![table](/analysis-project/mentorship-eligible-by-title.png)

## Summary of the Analysis
Planning for the future should be a top priority if Pewlett Hackard wants to survive the "silver tsunami." There is a disproportionate number of staff eligible for retirment (36,619) to the number eligible for the mentorship program (1,549). That is a ratio of 24:1.

Planning the mentorship program will require more analysis. 

### Additional Analysis

The first question to answer is: __"Which department and position has the most need of mentors?"__ 

A query that shows a breakdown by dept and title shows which positions within each department have the highest eliglble retirees and therefore the highest need of a mentoring program:

![table](/analysis-project/eligible-by-dept-title.png)

The second question to answer is: __"How many management positions are eligible for retirement in each dept?"__

A query that shows a breakdown by dept, filtered to only show senior positions reveals the depth of knowledge about to retire. 

![table](/analysis-project/eligible-mgmt-by-dept-title.png)


### Recommendations 
Ater reviewing the data along with these two additional queries, please consider the folloiwng:
1. Expand the qualifications for the mentorship program to reduce the ratio of mentors to open positions created by eligible retirees.
2. Focus or start the mentorship program on the Senior Engineers in the Development and Production departments. 
