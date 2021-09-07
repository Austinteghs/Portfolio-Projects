
--CosgroveHousing Portfolio Project

Select *
From PortfolioProject..CosgroveHousing

--------------------------------------------------------------------------------------------------------------------------

-- Standardizing Date Format

--This step is important because for example where the Saledate appeared as 2014-06-10 00:00:00.000, it would-
--have to conerted to just 2014-06-10 alone.

Select saleDateConverted, CONVERT(Date,SaleDate)
From PortfolioProject..CosgroveHousing


ALTER TABLE portfolioproject..CosgroveHousing
Add SaleDateConverted Date

Update portfolioproject..CosgroveHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)


 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

--Whats done here is that null property addresses are filled with the appropriate values

Select *
From PortfolioProject..CosgroveHousing
order by ParcelID



Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject..CosgroveHousing a
JOIN PortfolioProject..CosgroveHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject..CosgroveHousing a
JOIN PortfolioProject.dbo.CosgroveHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null




--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)

--For ProperyAddress

Select PropertyAddress
From PortfolioProject..CosgroveHousing


SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From PortfolioProject..CosgroveHousing


ALTER TABLE PortfolioProject..CosgroveHousing
Add PropertySplitAddress Nvarchar(255)

Update PortfolioProject..CosgroveHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE PortfolioProject..CosgroveHousing
Add PropertySplitCity Nvarchar(255)

Update PortfolioProject..CosgroveHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))


Select *
From PortfolioProject..CosgroveHousing



--For OwnerAddress

Select OwnerAddress
From PortfolioProject..CosgroveHousing


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From PortfolioProject..CosgroveHousing



ALTER TABLE PortfolioProject..CosgroveHousing
Add OwnerSplitAddress Nvarchar(255)

Update PortfolioProject..CosgroveHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE PortfolioProject..CosgroveHousing
Add OwnerSplitCity Nvarchar(255)

Update PortfolioProject..CosgroveHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE PortfolioProject..CosgroveHousing
Add OwnerSplitState Nvarchar(255)

Update PortfolioProject..CosgroveHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



Select *
From PortfolioProject..CosgroveHousing




--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject..CosgroveHousing
Group by SoldAsVacant
order by 2




Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From PortfolioProject..CosgroveHousing


Update PortfolioProject..CosgroveHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END






-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From PortfolioProject..CosgroveHousing
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress



Select *
From PortfolioProject..CosgroveHousing




---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns



Select *
From PortfolioProject..CosgroveHousing


ALTER TABLE PortfolioProject..CosgroveHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate






























