-- მოცემულ სკრიპტშია მონაცემები ADVENTURE WORKS 2019 - კომპანიის გაყიდვების შესახებ
-- გაყიდვები მოცემულია პროდუქტების , მაღაზიების და გაყიდვების თანამშრომლების ჭრილში
WITH overview as (
SELECT
		soh.SalesOrderID,
		soh.OrderDate,
		sod.ProductID,
		pc.Name as CategoryName,
		psc.Name as SubCategoryName,
		pr.Name as [product],--პროდუქტის დასახელება, შესაძლოა მოდიოდეს ფერიც და კლასიც
		pm.Name as Model, -- მხოლოდ პროდუქტის სახელი
		COUNT(*) over (partition by pr.productID) as TimeSold, -- ითვლის რამდენჯერ გაიყიდა თითოეული პროდუქტი
		pr.Color, 
		pr.Class,
		pr.StandardCost,
		pr.ListPrice,
		--(pr.ListPrice - pr.StandardCost)*SOD.OrderQty  as Profit,
		SUM(sod.LineTotal - (pr.StandardCost * sod.OrderQty)) AS Profit,
		SOD.OrderQty,
		SOD.LineTotal, -- პროდუქტის ფასი
		soh.TotalDue, -- SALEORDER-ის ჯამური ფასი
		s.Name as store,
		a.city,
	CASE 
		WHEN soh.SalesPersonID is not null THEN concat(p.LastName,' ',p.FirstName)
		ELSE 'No sales Person'
	END AS SalesPerson,
		e.MaritalStatus,
		e.Gender,
		e.SickLeaveHours,
		e.VacationHours,
		DATEDIFF(YEAR,e.BirthDate,getdate()) as Age		
FROM
	sales.SalesOrderHeader as soh
JOIN 
	sales.SalesOrderDetail as sod on soh.SalesOrderID=sod.SalesOrderID
JOIN 
	Production.Product as pr on sod.ProductID=pr.ProductID
LEFT JOIN
	sales.SalesPerson as sp on soh.SalesPersonID = sp.BusinessEntityID
LEFT JOIN
	person.Person as P on sp.BusinessEntityID = p.BusinessEntityID
LEFT JOIN	
	HumanResources.Employee as E on sp.BusinessEntityID = e.BusinessEntityID
LEFT JOIN
	sales.Customer as C on soh.CustomerID = c.CustomerID
LEFT JOIN
	sales.Store as S on c.StoreID = s.BusinessEntityID 
LEFT JOIN
	person.BusinessEntityAddress as bea on s.BusinessEntityID = bea.BusinessEntityID and bea.AddressTypeID = 3 -- ზედმეტი 1000 ჩანაწერი გამომდის ამ ფილტრის გარეშე, 3 = მთავარ ოფისს
LEFT JOIN	
	person.[Address] as a on bea.AddressID = a.AddressID 
LEFT JOIN 
	HumanResources.EmployeeDepartmentHistory as EDH on e.BusinessEntityID = EDH.BusinessEntityID
LEFT JOIN 
	Production.ProductSubcategory as psc on pr.ProductSubcategoryID = psc.ProductSubcategoryID
LEFT JOIN  
	Production.ProductCategory as pc on psc.ProductCategoryID=pc.ProductCategoryID
LEFT JOIN 
	production.ProductModel as pm on pr.ProductModelID=pm.ProductModelID 
GROUP BY soh.SalesOrderID,
		soh.OrderDate,
		sod.ProductID,
		pc.Name, --as CategoryName,
		psc.Name, --as SubCategoryName,
		pr.Name, --as [product],--პროდუქტის დასახელება, შესაძლოა მოდიოდეს ფერიც და კლასიც
		pm.Name, --as Model, -- მხოლოდ პროდუქტის სახელი
		--COUNT(*) over (partition by pr.productID) as TimeSold, -- ითვლის რამდენჯერ გაიყიდა თითოეული პროდუქტი
		pr.Color, 
		pr.Class,
		pr.StandardCost,
		pr.ListPrice,
		--(pr.ListPrice - pr.StandardCost)*SOD.OrderQty  as Profit,
		--SUM(sod.LineTotal - (pr.StandardCost * sod.OrderQty)) AS Profit,
		SOD.OrderQty,
		SOD.LineTotal, -- პროდუქტის ფასი
		soh.TotalDue, -- SALEORDER-ის ჯამური ფასი
		s.Name, --as store,
		a.city,
		PR.ProductID,
	CASE 
		WHEN soh.SalesPersonID is not null THEN concat(p.LastName,' ',p.FirstName)
		ELSE 'No sales Person'
	END,
		e.MaritalStatus,
		e.Gender,
		e.SickLeaveHours,
		e.VacationHours,
		DATEDIFF(YEAR,e.BirthDate,getdate()) --as Age		
)

SELECT
*
FROM overview
ORDER BY SalesOrderID



