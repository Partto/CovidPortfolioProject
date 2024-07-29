SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4


--SELECT *
--FROM PortfolioProject..CovidVaccinations
--WHERE continent IS NOT NULL
--ORDER BY 3,4


SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2

--TOTAL CASES VS TOTAL DEATHS
--showing likelyhood of dying if you contract covid in your country

SELECT location, date, total_cases, total_deaths, (CAST(total_deaths AS INT)/total_cases)*100 AS DeathPercent
FROM PortfolioProject..CovidDeaths
WHERE location LIKE '%STATES%' AND
continent IS NOT NULL
ORDER BY 1,2

--TOTAL CASES VS POPULATION
--PERCENTAGE THAT GOT COVID

SELECT location, date, population, total_cases, (total_cases/population)*100 PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%NIGERIA%'
WHERE continent IS NOT NULL
ORDER BY 1,2 

--LOOKING AT COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION

SELECT location, population, MAX(total_cases) HighestInfectionCount, MAX((total_cases/population))*100 PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%NIGERIA%'
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

--COUNTRIES WITH HIGHEST DEATH COUNT PER POPULATION

SELECT location, MAX(CAST(total_deaths AS INT)) TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%NIGERIA%'
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC



--BREAK THINGS DOWN BY CONTINENTS

--SHOWING CONTINENTS WITH THE HIGHEST DEATH COUNT PER POPULATION

SELECT continent, MAX(CAST(total_deaths AS INT)) TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%NIGERIA%'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

--GLOBAL NUMBERS

SELECT SUM(new_cases) total_cases, SUM(new_deaths) total_deaths, SUM(NULLIF(new_deaths,0))/SUM(NULLIF(new_cases,0))*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%STATES%' AND
WHERE continent IS NOT NULL
--GROUP BY date
ORDER BY 1,2

--LOOKING AT TOTAL POPULATION VS VACCINATION

SELECT DEATHS.continent, DEATHS.location, DEATHS.date, DEATHS.population, VACC.new_vaccinations,
SUM(CAST(new_vaccinations AS BIGINT)) OVER(PARTITION BY DEATHS.location ORDER BY DEATHS.location, DEATHS.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths DEATHS
JOIN PortfolioProject..CovidVaccinations VACC
ON DEATHS.location = VACC.location
AND DEATHS.date = VACC.date
WHERE DEATHS.continent IS NOT NULL
ORDER BY 2,3





--USE CTE

WITH popVsVacc (Continent, Location, Date, Population, New_vaccinations, RollingPeopleVaccinated)
AS
(
SELECT DEATHS.continent, DEATHS.location, DEATHS.date, DEATHS.population, VACC.new_vaccinations,
SUM(CAST(new_vaccinations AS BIGINT)) OVER(PARTITION BY DEATHS.location ORDER BY DEATHS.location, DEATHS.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths DEATHS
JOIN PortfolioProject..CovidVaccinations VACC
ON DEATHS.location = VACC.location
AND DEATHS.date = VACC.date
WHERE DEATHS.continent IS NOT NULL
--ORDER BY 2,3
)
SELECT *, (RollingPeopleVaccinated/Population)*100
FROM popVsVacc




--TEMP TABLE

DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(Continent NVARCHAR(255),
Location NVARCHAR(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
INSERT INTO #PercentPopulationVaccinated
SELECT DEATHS.continent, DEATHS.location, DEATHS.date, DEATHS.population, VACC.new_vaccinations,
SUM(CAST(new_vaccinations AS BIGINT)) OVER(PARTITION BY DEATHS.location ORDER BY DEATHS.location, DEATHS.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths DEATHS
JOIN PortfolioProject..CovidVaccinations VACC
ON DEATHS.location = VACC.location
AND DEATHS.date = VACC.date
--WHERE DEATHS.continent IS NOT NULL
--ORDER BY 2,3

SELECT *, (RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated



--CREATING VIEW TO STORE DATA FOR LATER VISUALIZATION


CREATE VIEW PercentPopulationVaccinated AS
SELECT DEATHS.continent, DEATHS.location, DEATHS.date, DEATHS.population, VACC.new_vaccinations,
SUM(CAST(new_vaccinations AS BIGINT)) OVER(PARTITION BY DEATHS.location ORDER BY DEATHS.location, DEATHS.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths DEATHS
JOIN PortfolioProject..CovidVaccinations VACC
ON DEATHS.location = VACC.location
AND DEATHS.date = VACC.date
WHERE DEATHS.continent IS NOT NULL
--ORDER BY 2,3

SELECT *
FROM PercentPopulationVaccinated