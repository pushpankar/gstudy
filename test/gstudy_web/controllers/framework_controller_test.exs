defmodule GstudyWeb.FrameworkControllerTest do
  use GstudyWeb.ConnCase

  alias Gstudy.Frameworks

  @create_attrs %{description: "some description", title: "some title"}
  @update_attrs %{description: "some updated description", title: "some updated title"}
  @invalid_attrs %{description: nil, title: nil}

  def fixture(:framework) do
    {:ok, framework} = Frameworks.create_framework(@create_attrs)
    framework
  end

  describe "index" do
    test "lists all frameworks", %{conn: conn} do
      conn = get conn, framework_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Frameworks"
    end
  end

  describe "new framework" do
    test "renders form", %{conn: conn} do
      conn = get conn, framework_path(conn, :new)
      assert html_response(conn, 200) =~ "New Framework"
    end
  end

  describe "create framework" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, framework_path(conn, :create), framework: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == framework_path(conn, :show, id)

      conn = get conn, framework_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Framework"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, framework_path(conn, :create), framework: @invalid_attrs
      assert html_response(conn, 200) =~ "New Framework"
    end
  end

  describe "edit framework" do
    setup [:create_framework]

    test "renders form for editing chosen framework", %{conn: conn, framework: framework} do
      conn = get conn, framework_path(conn, :edit, framework)
      assert html_response(conn, 200) =~ "Edit Framework"
    end
  end

  describe "update framework" do
    setup [:create_framework]

    test "redirects when data is valid", %{conn: conn, framework: framework} do
      conn = put conn, framework_path(conn, :update, framework), framework: @update_attrs
      assert redirected_to(conn) == framework_path(conn, :show, framework)

      conn = get conn, framework_path(conn, :show, framework)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, framework: framework} do
      conn = put conn, framework_path(conn, :update, framework), framework: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Framework"
    end
  end

  describe "delete framework" do
    setup [:create_framework]

    test "deletes chosen framework", %{conn: conn, framework: framework} do
      conn = delete conn, framework_path(conn, :delete, framework)
      assert redirected_to(conn) == framework_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, framework_path(conn, :show, framework)
      end
    end
  end

  defp create_framework(_) do
    framework = fixture(:framework)
    {:ok, framework: framework}
  end
end
