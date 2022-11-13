select *
From portfolioprojects..Nash
  
  -- converting datatype of data column
select count(*) from portfolioprojects..Nash
where propertyaddress is null


update   portfolioprojects..Nash
set saledate=cast(saledate as date) 

select saledate,convert(date,saledate) as newdate
From portfolioprojects..Nash

select saledate from portfolioprojects..Nash

-- upper queries are not working

alter table portfolioprojects..Nash
add NewSaleDate date

update portfolioprojects..Nash
set NewSaleDate=convert(date,saledate)

select NewSaleDate,saledate from  portfolioprojects..Nash



--breaking down property address in city and state
select propertyaddress 
from portfolioprojects..Nash

select propertyaddress ,parcelid
from portfolioprojects..Nash
where PropertyAddress is null
order by parcelid


--cheked that is uniqueid is individual for each record
--yes it is
select count(distinct([UniqueID ] )) from portfolioprojects..Nash

--filling address in empty cell of propertyaddress column

select a.parcelid,a.propertyaddress,b.parcelid,b.propertyaddress,ISNULL(a.propertyaddress,b.propertyaddress)
from portfolioprojects..Nash as a
join portfolioprojects..Nash as b
on a.parcelid=b.ParcelID 
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

select a.parcelid,b.parcelid,a.propertyaddress,b.propertyaddress 
from portfolioprojects..Nash a join  portfolioprojects..Nash as b
on a.parcelid=b.parcelid
where a.propertyaddress is null

update a
set propertyaddress=ISNULL(a.propertyaddress,b.propertyaddress)
from portfolioprojects..Nash as a
join portfolioprojects..Nash as b
on a.parcelid=b.ParcelID 
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

--Breaking  propertyaddress into individual column like(Address,city)


select propertyaddress
from portfolioprojects..Nash 

-- here substring is to find substring from given column
--CHARINDEX gives the position of  substring from the given  string/column
--  -1 to remove comma from the last iin  the result


select SUBSTRING(propertyaddress,1,CHARINDEX(',',propertyaddress)-1) as Address,
SUBSTRING(propertyaddress,CHARINDEX(',',propertyaddress)+1,LEN(propertyAddress)) as PropertCity
from portfolioprojects..Nash 


--create column1
ALTER TABLE portfolioprojects..Nash
Add PropertSplitAddress Nvarchar(250)

--update column1
Update portfolioprojects..Nash
set PropertSplitAddress =SUBSTRING(propertyaddress,1,CHARINDEX(',',propertyaddress)-1)


--create column2
ALTER TABLE portfolioprojects..Nash
Add PropertySplitcity Nvarchar(250)

--update column2
Update portfolioprojects..Nash
set PropertySplitcity =SUBSTRING(propertyaddress,CHARINDEX(',',propertyaddress)+1,LEN(propertyAddress))



select OwnerAddress
From portfolioprojects..Nash


--select a.parcelid,a.owneraddress,b.owneraddress,a.propertyaddress,b.Propertyaddress
--from portfolioprojects..Nash as a
--join portfolioprojects..Nash as b
--on a.propertyaddress=b.Propertyaddress
--and a.[UniqueID ] <> b.[UniqueID ]

-- split owner address int address,city,state

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From portfolioprojects..Nash



ALTER TABLE portfolioprojects..Nash
Add OwnerSplitAddress Nvarchar(255);

Update portfolioprojects..Nash
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE portfolioprojects..Nash
Add OwnerCity Nvarchar(255);

Update portfolioprojects..Nash
SET OwnerCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE portfolioprojects..Nash
Add OwnerState Nvarchar(255);

Update portfolioprojects..Nash
SET OwnerState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



Select *
From portfolioprojects..Nash




-- change y and n to yes and no in sild as vecant field
select DISTINCT(soldasvacant),count(soldasvacant)
from  portfolioprojects..Nash
group by soldasvacant
order by 2



select soldasvacant
,CASE when soldasvacant = 'Y' then 'Yes'
      when soldasvacant ='N' then 'No'
	  else soldasvacant
	  end
from portfolioprojects..Nash

update portfolioprojects..Nash
set soldasvacant=CASE when soldasvacant = 'Y' then 'Yes'
      when soldasvacant ='N' then 'No'
	  else soldasvacant
	  end


--Remove duplicates
with RownumCTE as(
select * , row_number( ) over(
                                partition by 
                                parcelid,
			                    Saleprice,
			                     Saledate,LegalReference
			                    Order By uniqueID          ) row_num
 from portfolioprojects..Nash)
 --delete
 select *
 from RownumCTE 
 where row_num>1


 



--deleting column


Alter table portfolioprojects..Nash
drop column propertyaddress,owneraddress


Select *
From portfolioprojects..Nash