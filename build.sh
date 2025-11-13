#!/bin/sh
set -e

tmpdf=Dockerfile
rm -f "$tmpdf"

cat > "$tmpdf" <<EOF
FROM ubuntu:22.04
RUN apt-get update && apt-get install -y build-essential libgcc-s1
WORKDIR /app
COPY loader.c ./
RUN gcc -fPIC -c loader.c -o loader.o && gcc loader.o -ldl -o hello_dynamic
EOF

echo "[build_all] Building plugin images and generating Dockerfile..."

for df in hello_docker/Dockerfile.*; do
    lang=$(basename "$df" | cut -d. -f2)
    img=hello_$lang
    echo "[build_all] Building $img from $df..."
    docker build -f "$df" -t "$img" .
    # Find .so file(s) in the image
    sofiles=$(docker run --rm "$img" sh -c 'ls /src/*.so 2>/dev/null || ls /app/*.so 2>/dev/null || true')
    for so in $sofiles; do
      soname=$(basename "$so")
      echo "COPY --from=$img $so ./hello_plugins/$soname" >> "$tmpdf"
    done
done

echo 'CMD ["./hello_dynamic"]' >> "$tmpdf"

echo "[build_all] Building final image hello_final..."
docker build -f "$tmpdf" -t hello_final .

echo "[build_all] Done. Run: docker run --rm hello_final"