-- 1. TABELA DE ORGANIZAÇÕES
CREATE TABLE IF NOT EXISTS public.organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
CREATE TABLE project (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL
        REFERENCES organization(organization_id),
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL
);

INSERT INTO public.organization (name, description, contact_email, logo_filename)
VALUES
    ('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
    ('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
    ('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png')
ON CONFLICT DO NOTHING;

-- 2. TABELA DE PROJETOS (A que faltava)
CREATE TABLE IF NOT EXISTS public.project (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER REFERENCES public.organization(organization_id),
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL
);

-- Inserção de 15 projetos para corresponder às suas categorias abaixo
-- (Substitua pelos seus projetos reais se os tiver guardados)
INSERT INTO public.project (organization_id, title, description, location, date) 
VALUES 
    (1, 'Community Build Day', 'Building homes for families.', 'Downtown', '2026-12-01'),
    (2, 'School Garden Setup', 'Planting a garden for students.', 'Local High School', '2026-12-05'),
    (1, 'Park Cleanup', 'Cleaning up the local park.', 'City Park', '2026-12-10'),
    (3, 'Food Drive', 'Collecting food for the homeless.', 'Community Center', '2026-12-12'),
    (1, 'Shelter Renovation', 'Painting and fixing the shelter.', 'Main St Shelter', '2026-12-15'),
    (2, 'Tree Planting', 'Planting 100 trees.', 'Westside Park', '2026-12-18'),
    (2, 'River Cleanup', 'Removing trash from the river.', 'Riverwalk', '2026-12-20'),
    (2, 'Recycling Workshop', 'Teaching kids about recycling.', 'Library', '2026-12-22'),
    (3, 'Tutoring Program', 'Math and reading tutoring.', 'Youth Center', '2026-12-28'),
    (1, 'Winter Coat Drive', 'Collecting winter coats.', 'Town Square', '2027-01-05'),
    (3, 'Senior Center Visit', 'Playing games with seniors.', 'Oakwood Center', '2027-01-10'),
    (1, 'Playground Building', 'Building a new playground.', 'Eastside', '2027-01-15'),
    (3, 'Blood Drive', 'Community blood donation event.', 'Hospital', '2027-01-20'),
    (2, 'Afterschool Coding', 'Teaching basic HTML to kids.', 'Tech Hub', '2027-01-25'),
    (2, 'Beach Cleanup', 'Clearing plastic from the beach.', 'North Beach', '2027-01-30')
ON CONFLICT DO NOTHING;

-- 3. TABELA DE CATEGORIAS
CREATE TABLE IF NOT EXISTS public.category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE
);

INSERT INTO public.category (name) VALUES 
    ('Community Service'),
    ('Education'),
    ('Environment')
ON CONFLICT (name) DO NOTHING;

-- 4. TABELA DE RELAÇÃO PROJETO-CATEGORIA
CREATE TABLE IF NOT EXISTS public.project_category (
    project_id INTEGER REFERENCES public.project(project_id),
    category_id INTEGER REFERENCES public.category(category_id),
    PRIMARY KEY (project_id, category_id)
);

INSERT INTO public.project_category (project_id, category_id) VALUES 
    (1, 1), (2, 2), (3, 1), (4, 1), (5, 1),
    (6, 3), (7, 3), (8, 3), (9, 2), (9, 3),
    (10, 1), (11, 1), (12, 1), (13, 1), (14, 2), (15, 3)
ON CONFLICT DO NOTHING;
INSERT INTO project
    (organization_id, title, description, location, date)
VALUES
(1, 'Community Park Renovation',
 'Repair benches and improve paths in a community park.',
 'Central Community Park', '2026-11-10'),

(1, 'School Painting Day',
 'Paint classrooms and refresh school common areas.',
 'Sunrise Community School', '2026-11-14'),

(1, 'Accessible Ramp Construction',
 'Build an access ramp at a neighborhood community center.',
 'Hope Community Center', '2026-11-18'),

(1, 'Playground Restoration',
 'Repair playground equipment and improve the play area.',
 'Riverside Playground', '2026-11-21'),

(1, 'Community Library Repairs',
 'Repair bookshelves and improve the reading space.',
 'Neighborhood Library', '2026-11-28'),

(2, 'Community Vegetable Garden',
 'Plant vegetables to support local families.',
 'Green Valley Garden', '2026-11-11'),

(2, 'Composting Workshop',
 'Teach residents how to compost household food scraps.',
 'Urban Farming Center', '2026-11-15'),

(2, 'Fruit Tree Planting',
 'Plant fruit trees in shared neighborhood spaces.',
 'Eastside Community Square', '2026-11-19'),

(2, 'School Garden Project',
 'Help students plant and care for a school garden.',
 'Sunrise Community School', '2026-11-22'),

(2, 'Local Harvest Distribution',
 'Harvest and distribute fresh produce to local families.',
 'GreenHarvest Distribution Center', '2026-11-29'),

(3, 'Food Donation Drive',
 'Collect and organize food donations for local families.',
 'Hope Community Center', '2026-11-12'),

(3, 'Senior Support Day',
 'Visit older adults and help with everyday tasks.',
 'Sunshine Senior Center', '2026-11-16'),

(3, 'Neighborhood Cleanup',
 'Collect litter and clean shared neighborhood spaces.',
 'Riverside Neighborhood', '2026-11-20'),

(3, 'Clothing Donation Sorting',
 'Sort donated clothing for distribution to people in need.',
 'UnityServe Donation Center', '2026-11-23'),

(3, 'Children Reading Day',
 'Read stories and organize educational activities for children.',
 'Neighborhood Library', '2026-11-30');
