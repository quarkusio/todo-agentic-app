# Handy sets of commands to run side operations usually described in the doc otherwise
# expects podman and quarkus CLI

postgres := "postgres:15-bullseye"

# Detect which container runtime is available
container_runtime := `command -v docker >/dev/null 2>&1 && echo "docker" || echo "podman"`


# Start the database using podman or docker
start-infra:
    {{container_runtime}} run --ulimit memlock=-1:-1 -it --rm=true \
        --name postgres-quarkus-rest-http-crud \
        -e POSTGRES_USER=restcrud \
        -e POSTGRES_PASSWORD=restcrud \
        -e POSTGRES_DB=rest-crud \
        -p 5432:5432 {{postgres}}

# Stop the database using podman or docker
stop-infra:
    {{container_runtime}} stop $({{container_runtime}} ps -q --filter ancestor={{postgres}})

# Show which container runtime will be used
show-runtime:
    @echo "Using container runtime: {{container_runtime}}"

#Using quarkus CLI, build in native
native:
    quarkus build --no-tests --native