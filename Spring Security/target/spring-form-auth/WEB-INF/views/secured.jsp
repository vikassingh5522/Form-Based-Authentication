<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
        }

        #threejs-background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }

        .content {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
            text-align: center;
            backdrop-filter: blur(5px);
        }

        h1 {
            color: #333;
            margin-bottom: 30px;
        }

        form {
            margin-top: 20px;
        }

        button {
            padding: 12px 25px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        button:hover {
            background-color: #c82333;
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
</head>
<body>
    <div id="threejs-background"></div>

    <div class="content">
        <h1>Welcome to Secured Area</h1>

        <form action="<c:url value='/logout' />" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <button type="submit">Logout</button>
        </form>
    </div>

    <script>
        // Three.js initialization
        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
        const renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true });
        renderer.setSize(window.innerWidth, window.innerHeight);
        document.getElementById('threejs-background').appendChild(renderer.domElement);

        // Create a colorful grid of lines
        const gridSize = 10;
        const gridDivisions = 20;
        const gridHelper = new THREE.GridHelper(gridSize, gridDivisions);

        // Make the grid colorful
        gridHelper.material.color.setHSL(Math.random(), 0.5, 0.5);
        scene.add(gridHelper);

        // Add floating tetrahedrons
        const tetrahedrons = [];
        const tetraGeometry = new THREE.ConeGeometry(0.2, 0.4, 4);

        for(let i = 0; i < 15; i++) {
            const material = new THREE.MeshBasicMaterial({
                color: new THREE.Color(Math.random(), Math.random(), Math.random()),
                transparent: true,
                opacity: 0.8
            });

            const tetrahedron = new THREE.Mesh(tetraGeometry, material);

            tetrahedron.position.x = (Math.random() - 0.5) * 8;
            tetrahedron.position.y = (Math.random() - 0.5) * 8;
            tetrahedron.position.z = (Math.random() - 0.5) * 8;

            tetrahedron.rotation.x = Math.random() * Math.PI;
            tetrahedron.rotation.y = Math.random() * Math.PI;

            tetrahedron.userData = {
                speedX: Math.random() * 0.01 - 0.005,
                speedY: Math.random() * 0.01 - 0.005,
                speedZ: Math.random() * 0.01 - 0.005,
                rotSpeedX: Math.random() * 0.01,
                rotSpeedY: Math.random() * 0.01
            };

            scene.add(tetrahedron);
            tetrahedrons.push(tetrahedron);
        }

        camera.position.z = 5;

        // Animation loop
        function animate() {
            requestAnimationFrame(animate);

            // Rotate grid
            gridHelper.rotation.x += 0.001;
            gridHelper.rotation.y += 0.001;

            // Animate tetrahedrons
            tetrahedrons.forEach(tetra => {
                tetra.position.x += tetra.userData.speedX;
                tetra.position.y += tetra.userData.speedY;
                tetra.position.z += tetra.userData.speedZ;

                tetra.rotation.x += tetra.userData.rotSpeedX;
                tetra.rotation.y += tetra.userData.rotSpeedY;

                // Boundary check
                if(Math.abs(tetra.position.x) > 4) tetra.userData.speedX *= -1;
                if(Math.abs(tetra.position.y) > 4) tetra.userData.speedY *= -1;
                if(Math.abs(tetra.position.z) > 4) tetra.userData.speedZ *= -1;
            });

            renderer.render(scene, camera);
        }

        animate();

        // Handle window resize
        window.addEventListener('resize', () => {
            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(window.innerWidth, window.innerHeight);
        });
    </script>
</body>
</html>